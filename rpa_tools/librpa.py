from config import Config
from helpers import get_root_path
from ssh import RPAPlaceSSHConnection, RPAServerSSHConnection

from dataclasses import dataclass, field
from datetime import datetime
from enum import Enum
from queue import Queue

import logging
import os
import re
import threading
import yaml


rpa_time_fmt = "%Y-%m-%d %H:%M.%S"


class PlaceState(Enum):
	UNKNOWN = 0
	FREE = 1
	LOCKED = 2


@dataclass
class VideoStream:
	name: str
	url: str

	def open(self, config: dict):
		quiet_opts = "" if config.get("debug_streams", False) else "2>/dev/null 1>/dev/null"
		cmd = f"{config['stream_cmd']} {self.url} {quiet_opts} &"
		logging.info(cmd)

		os.system(cmd)


@dataclass
class Place:
	name: str
	state: PlaceState
	release_time: datetime = None

	def __str__(self):
		s = f"{self.name} is "
		if self.state == PlaceState.LOCKED:
			s += f"locked until {self.release_time}."
		elif self.state == PlaceState.FREE:
			s += "free."
		elif self.state == PlaceState.UNKNOWN:
			s += "in unknown state."
		return s

	@classmethod
	def from_locked(cls, line):
		m = re.match("(?P<name>ti\d+) .* (?P<state>locked) [^\d]+(?P<time>.*)", line)
		if m:
			try:
				time = datetime.strptime(m["time"], "%Y-%m-%d %H:%M.%S")
			except ValueError:
				time = None
			return cls(m["name"], PlaceState.LOCKED, time)

	@classmethod
	def from_free(cls, line):
		m = re.match("(?P<name>ti\d+) .* (?P<state>ready and waiting)", line)
		if m:
			return cls(m["name"], PlaceState.FREE)

	@classmethod
	def from_unknown(cls, line):
		m = re.match("(?P<name>ti\d+)", line)
		if m:
			return cls(m["name"], PlaceState.UNKNOWN)


@dataclass
class Places:
	header: str
	hosts: [Place] = field(default_factory=list)

	def __str__(self):
		return '\n'.join([self.header] + [str(host) for host in self.hosts])

	@classmethod
	def from_rpa_status(cls, response: iter):
		lines = response.splitlines()

		c = Places(lines[0])
		for line in lines[1:]:
			p = Place.from_locked(line)
			if p is None:
				p = Place.from_free(line)
			if p is None:
				p = Place.from_unknown(line)
			if p is not None:
				c.hosts.append(p)
		return c

	def __iter__(self):
		for host in self.hosts:
			yield host

	def __getitem__(self, idx: int):
		return self.hosts[idx]


class RPAStatus(Enum):
	UNKNOWN = 0
	ASSIGNED = 1
	WAITING = 2
	EXTENDED = 3
	INFO = 4
	REPLACE = 5
	BYE = 6

	@classmethod
	def from_string(cls, s: str):
		attr = cls.UNKNOWN
		try:
			attr = getattr(cls, s.upper())
		except AttributeError:
			pass

		return attr


@dataclass
class RPAResponse():
	status: RPAStatus
	reason: str = None
	host: str = None
	videostreams: [VideoStream] = None
	deadline: [datetime] = None

	@classmethod
	def from_yml_str(cls, msg: str):
		dct = yaml.load(msg, Loader=yaml.SafeLoader)

		r = cls(RPAStatus.from_string(dct["status"]))
		r.reason = dct.get("reason")
		r.host = dct.get("host")
		r.videostreams = []
		for name, url in dct.get("videostreams", {}).items():
			r.videostreams.append(VideoStream(name, url))

		try:
			r.deadline = datetime.strptime(dct.get("deadline", ""), rpa_time_fmt)
		except ValueError:
			r.deadline = None

		return r

	@property
	def name(self):
		try:
			return self.host.split('.')[0]
		except IndexError:
			return self.host
		except AttributeError:
			return None


class ConnectionStatus(Enum):
	UNKNOWN = 0
	UNASSIGNED = 1
	ASSIGNED = 2
	QUEUED = 3

	@classmethod
	def from_response(cls, r: RPAResponse):
		cs = cls.UNKNOWN
		if r.status == RPAStatus.ASSIGNED:
			cs = cls.ASSIGNED
		elif r.status == RPAStatus.INFO:
			if r.reason == "You are currently unknown.":
				cs = cls.UNASSIGNED
			elif r.reason == "You are currently in wait queue.":
				cs = cls.QUEUED
		return cs


class RPAPlace(RPAPlaceSSHConnection):

	def __init__(self, config: dict, host_url: str, videostreams: [VideoStream]):
		super().__init__(config, host_url)
		self.host_url = host_url
		self.videostreams: [VideoStream] = videostreams

	def getStreamURL(self, name):
		for stream in self.videostreams:
			if stream.name == name:
				return stream.url

		return None

	def getVideoStream(self, name):
		for vs in self.videostreams:
			if vs.name == name:
				return vs
		return None
		
	@property
	def name(self):
		try:
			return self.host_url.split('.')[0]
		except IndexError:
			return self.host_url

	def program(self, remote_filename):
		cmd = ["remote.py", "-p", os.path.join(".rpa_shell", remote_filename)]
		self.runCommand(cmd)


# TODO: error-handling
class RPAExecThread(threading.Thread):

	def __init__(self, kwargs):
		super().__init__(target=self.__class__)
		self.outcome = kwargs["rpa_outcome"]
		self.outcome.clear()  # still set from last lock
		self.queue = kwargs["queue"]
		self.runCmd = kwargs["runCmd"]
		self.rpa_cmd = ["rpa", "-V", "MESSAGE-SET=vlsi-yaml"]
		if kwargs["place"] is not None:
			self.rpa_cmd.extend(["want-host", kwargs["place"]])
		else:
			self.rpa_cmd.extend(["lock"])

		self.proc = None
		self._locked = False
		self.yml_lines = []

	def _update_lock_state(self, r):
		if r.status in [RPAStatus.ASSIGNED, RPAStatus.REPLACE, RPAStatus.EXTENDED]:
			self.outcome.set()
			self._locked = True
		else:
			self._locked = False

	def _queueRPAResponse(self, line):
		MSG_COMPLETE = "---"

		if line == MSG_COMPLETE:
			r = RPAResponse.from_yml_str('\n'.join(self.yml_lines))
			self._update_lock_state(r)
			self.queue.put(r)
		else:
			self.yml_lines.append(line)

	def _execute_command(self):
		logging.debug(self.rpa_cmd)

		# allocate pty to kill rpa when connection goes down
		with self.runCmd(self.rpa_cmd, ssh_args=["-tt"]) as p:
			self.proc = p

			while True:
				line = p.stdout.readline()
				if line == "":
					break  # broken pipe, stop reading
				else:
					self._queueRPAResponse(line.rstrip())

			logging.info("RPA process dead")

		logging.debug("RPAExecThread done")

	def run(self):
		try:
			self._execute_command()
		# TODO: gracefully quit on exception
		# TODO: check exception that would be raised on connection going down
		except Exception as e:
			logging.error(f"RPAExecThread died unexpectedly: {e}")
		finally:
			self.outcome.set()

	def terminate(self):
		if self.proc is not None:
			self.proc.terminate()

	@property
	def locked(self):
		return self._locked


class RPAClient(RPAServerSSHConnection):
	config_class = Config
	default_config = {
		"username": None,
		"identity": None,
		"rpaserver": "ssh.tilab.tuwien.ac.at",
		"cntrl_main": "~/.rpa_cntrl_main",
		"cntrl_host": "~/.rpa_cntrl_host",
		"stream_cmd": "ffplay -fflags nobuffer -flags low_delay -framedrop -hide_banner -loglevel error -autoexit",
	}

	def __enter__(self):
		return self

	def __exit__(self, exc_type, exc_value, traceback):
		self.terminate()

	@property
	def _rpa_is_locked(self):
		if self.rpa_main is True:
			if self.t_rpa:
				return self.t_rpa.locked
			else:
				return False
		else:
			return self.LockState.status == RPAStatus.ASSIGNED

	def _rpa_connect(self, place):
		if self.rpa_main:
			args = {
				"rpa_outcome": self.rpa_outcome,
				"queue": self.rpa_msg_queue,
				"place": place,
				"runCmd": self.interactiveCommand,
			}
			self.t_rpa = RPAExecThread(kwargs=args)
			self.t_rpa.start()
			
			self.rpa_outcome.wait()

		r = self.LockState
		if r.status is not RPAStatus.ASSIGNED:
			if self.rpa_main:
				raise ValueError("""Failed to lock/connect to Place. Possible causes could be:
  * Unexpected response from RPA server
  * Main ssh-connection went down while trying to lock
  Connect again!""")
			else:
				raise ValueError("""Place lost, connect again!""")

		logging.debug(f"place should be assigned now: {r}")
		self.place = RPAPlace(self.config, r.host, r.videostreams)

	def require_place_connection(fn):
		def wrapper(self, *args, **kwargs):
			place = args[0] if args else kwargs.get("place", None)

			if self._rpa_is_locked is False:
				self._rpa_connect(place)
			elif self.place is None:
				# client connection, locked but not connected yet
				self._rpa_connect(place)

			return fn(self, *args, **kwargs)
		return wrapper

	def __init__(self, import_name, rpa_main: bool = True):
		root_path = get_root_path(import_name)
		self.config: Config = self.config_class(root_path, self.default_config)
		super().__init__(self.config)

		self.place: RPAPlace = None
		self.rpa_main = rpa_main
		self.rpa_msg_queue: Queue = Queue()
		self.rpa_outcome: threading.Event = threading.Event()
		self.t_rpa = None

	@property
	def RPAEventQueue(self):
		return self.rpa_msg_queue

	@property
	def Places(self):
		cmd = ["-q", "rpa", "-V", "MESSAGE-SET=vlsi-yaml", "status"]
		res = self.runCommand(cmd, capture_stdout=True)
		return Places.from_rpa_status(res.stdout)

	def releasePlace(self):
		if self.t_rpa is not None:
			logging.info("stopping rpa thread")
			self.t_rpa.terminate()
			self.t_rpa.join()   # will wait until terminated
			self.t_rpa = None
			logging.info("rpa thread terminated")
		else:
			logging.info("rpa thread not running")

	@property
	def LockState(self):
		# TODO: use messages from rpa to get locked state
		# * e.g. latest ASSIGNED message after a BYE message
		# * REPLACE still requires additional query
		#if self.rpa_main is True and self.rpa_locked.is_set():
		#else:

		# -q: prevent ssh from printing connected/disconnected messages
		query = ["-q", "rpa", "-V", "MESSAGE-SET=vlsi-yaml", "lock-state"]
		res = self.runCommand(query, capture_stdout=True)

		return RPAResponse.from_yml_str('\n'.join(res.stdout.splitlines()[:-1]))

	@property
	def ConnectionStatus(self):
		return ConnectionStatus.from_response(self.LockState)

	@require_place_connection
	def Place(self, place=None):
		return self.place
t_rpa = None
			logging.info("rpa thread terminated")
		else:
			logging.info("rpa thread not running")

	@property
	def LockState(self):
		# TODO: use messages from rpa to get locked state
		# * e.g. latest ASSIGNED message after a BYE message
		# * REPLACE still requires additional query
		#if self.rpa_main is True and self.rpa_locked.is_set():
		#else:

		# -q: prevent ssh from printing connected/disconnected messages
		query = ["-q", "rpa", "-V", "MESSAGE-SET=vlsi-yaml", "lock-state"]
		res = self.runCommand(query, capture_stdout=True)

		return RPAResponse.from_yml_str('\n'.join(res.stdout.splitlines()[:-1]))

	@property
	def ConnectionStatus(self):
		return ConnectionStatus.from_response(self.LockState)

	@require_place_connection
	def Place(self, place=None):
		return self.place
