from abc import ABC
from os.path import exists, expanduser

import logging
import subprocess
import threading

#TODO:
# * specify forwardings to delete, get list of all forwardings and allow removing them
# * check returncodes
# * check why shell is needed for main connection to place


def log_command(args: [str, iter]):
	try:
		log_msg = ' '.join(args)
	except FileNotFoundError:
		log_msg = args

	logging.debug(log_msg)


class SSHThread(threading.Thread):
	def __init__(self, args, thread_outcome: threading.Condition):
		super().__init__(target=self.__class__)
		self.exc = None
		self.proc = None
		self.args = args
		self._thread_outcome = thread_outcome

	def _execute_command(self):
		log_command(self.args)

		popen_args = {
			"stdin": subprocess.PIPE,
			"stdout": subprocess.PIPE,
			"stderr": subprocess.PIPE,
		# TODO: fix needing shell for host master-connection
			"shell": True,
			"encoding": "utf-8",  # text not supported in python3.6
		}

		with subprocess.Popen(' '.join(self.args), **popen_args) as p:
			# allow external termination
			self.proc = p

			line = p.stdout.readline()  # blocking
			if line.startswith("Last "):
				self._thread_outcome.set()
			elif line == "":
				error_line = ''.join(p.stderr.readlines()).strip()
				logging.info(f"error message: {error_line}")

				# only raise when process dies anyway otherwise
				# __exit__ waits for termination and therefore
				# deadlocks!
				raise BrokenPipeError(error_line)
			else:
				err_msg = f"Expected login line, got: '{line.strip()}'"
				p.terminate()  # will raise I/O exception on next readline()
				logging.error(err_msg)

			# Note:
			# Although not a problem here, potentially deadlocks when process
			# fills stdout os-buffer as it can't write to stdout anymore and
			# buffer won't get read
			p.wait()
			logging.debug("SSH process dead")

		if p.returncode == 255:
			lines = p.stdout.readlines()
			logging.debug("ssh terminated with error (255)")
			logging.debug("errorcode: " + ''.join(lines).strip())

		logging.debug("SSHThread done")

	def join(self, *args, **kwargs):
		super().join(*args, **kwargs)
		if self.exc:
			exc = self.exc
			self.exc = None
			raise exc

	def run(self):
		try:
			self._execute_command()
			logging.info(f"closed ssh connection: {self.args[-1]}")
		except AttributeError as e:
			print("exception caught, NoneType not subscritable", e)
		except ValueError as e:
			if "I/O operation on closed file." in e.args:
				# happens when main connection is closed and childs
				# still running
				pass
			else:
				raise
		except Exception as e:
			# TODO:
			print(">>", type(e), e)
			self.exc = e
		finally:
			logging.info("finally thread is done")
			# make sure to unblock main thread also on error
			self._thread_outcome.set()

	def terminate(self):
		self.proc.terminate()

	@property
	def connected(self):
		logging.debug(f"proc is: {self.proc}")
		return self.proc is not None and self.proc.poll() is None


class SSHConnection(ABC):

	def requireConnection(fn):
		def wrapper(self, *args, **kwargs):
			if not self.connected:
				self.forwardings = []
				self.connect()
			return fn(self, *args, **kwargs)
		return wrapper

	def __init__(self, config: dict):
		self.config = config
		self.t = None
		self.forwardings = []

	@property
	def main_conn_args(self):
		args = [
			"ssh",
			"-M",						# create main connection
			"-oControlMaster=yes",		# share multiple sessions over single connection
			"-oServerAliveInterval=300",
			"-oPasswordAuthentication=no",
			"-tt",						# pty ensures to stop running remote process on
										# termination by forwarding signals
		]
		if self.config["identity"]:
			args.append(f"-i{expanduser(self.config['identity'])}")

		return args

	@property
	def CntrlPath(self):
		return self.config[self.cntrl_path_key]

	def _gen_command(self, command: list = [], ssh_args: list = []):
		args = ["ssh"]
		args.extend(ssh_args)
		args.extend([
			f"-oControlPath={self.CntrlPath}",
			f"{self.target}",
		])
		args.extend(command)

		log_command(args)
		return args

	def connect(self):
		thread_outcome = threading.Event()
		self.t = SSHThread(self.main_conn_args, thread_outcome)
		self.t.start()
		logging.info("starting thread")

		thread_outcome.wait()
		if not self.connected:
			self.t.join(timeout=0.1)
			raise ConnectionError("SSH Connection died without error!")

	def terminate(self):
		if self.t is not None:
			self.t.terminate()
			self.t.join()  # will wait until terminated

	@property
	def connected(self):
		if self.t is not None and self.t.connected:
			# main-connection mode
			return True
		elif exists(self.CntrlPath):
			# connecting via already existing connection
			return True
		else:
			return False

	@requireConnection
	def interactiveCommand(self, command: list, ssh_args: list = []):
		args = self._gen_command(command, ssh_args)
		popen_args = {
			"stdin": subprocess.PIPE,
			"stdout": subprocess.PIPE,
			"stderr": subprocess.STDOUT,
			"encoding": "utf-8",  # text not supported in python3.6
		}
		return subprocess.Popen(args, **popen_args)

	@requireConnection
	def runCommand(self, command: list, ssh_args: list = [], capture_stdout: bool = False, shell: bool = False):
		if shell:
			command = [command]
		args = self._gen_command(command, ssh_args)
		stdout = subprocess.PIPE if capture_stdout else None
		if shell:
			args = ' '.join(args)
		return subprocess.run(args, stdout=stdout, shell=shell, encoding="utf-8")
	
	@requireConnection
	def runShell(self):
		args = self._gen_command(ssh_args=[
			"-X",  # enable X11-forwarding
			"-Y",  # trusted X11-forwarding
			"-C",  # use compression
		])
		subprocess.run(args)

	@requireConnection
	def fileTransport(self, local_path: str, remote_path: str, direction: str):
		local_path = expanduser(local_path)
		remote_path = f"{self.target}:{remote_path}"

		args = [
			"scp",
			f"-oControlPath={self.CntrlPath}",
			f"{local_path}" if direction == "put" else f"{remote_path}",
			f"{remote_path}" if direction == "put" else f"{local_path}",
		]

		log_command(args)
		subprocess.run(args)

	def putFile(self, local_path, remote_path):
		self.fileTransport(local_path, remote_path, "put")

	def getFile(self, local_path, remote_path):
		self.fileTransport(local_path, remote_path, "get")

	@requireConnection
	def addPortForwarding(self, local_port: int, remote_ip: str = "localhost", remote_port: int = None):
		if remote_port is None:
			remote_port = local_port

		fwd_spec = f"localhost:{local_port}:{remote_ip}:{remote_port}"

		args = self._gen_command(ssh_args=[
			"-Oforward",
			f"-L{fwd_spec}",
		])

		rv = subprocess.run(args, stdout=subprocess.PIPE, stdin=subprocess.PIPE, stderr=subprocess.PIPE)
		if rv.returncode != 0:
			raise ValueError(f"Failed to add portforwarding: {fwd_spec}!")
		else:
			self.forwardings.append(fwd_spec)
			logging.debug(f"Forwarding added: {fwd_spec}")

	@requireConnection
	def clearPortForwardings(self):
		ssh_args = ["-Ocancel"]
		for forwarding in self.forwardings:
			ssh_args.append(f"-L{forwarding}")

		args = self._gen_command(ssh_args=ssh_args)
		rv = subprocess.run(args, stdout=subprocess.PIPE)
		if rv.returncode != 0:
			raise ValueError("Failed to clear port forwardings!")
		else:
			logging.debug("Forwardings cleared")


# * require username, host to be set
class RPAServerSSHConnection(SSHConnection):

	def __init__(self, config, *args, **kwargs):
		super().__init__(config, *args, **kwargs)
		self.cntrl_path_key = "cntrl_main"

	@property
	def main_conn_args(self):
		cfg = self.config

		args = super().main_conn_args
		args.extend([
			f"-oControlPath={self.CntrlPath}",
			f"{cfg['username']}@{cfg['rpaserver']}",
		])
		return args

	@property
	def target(self):
		cfg = self.config
		return f"{cfg['username']}@{cfg['rpaserver']}"

class RPAPlaceSSHConnection(SSHConnection):

	def __init__(self, config, host_url, *args, **kwargs):
		super().__init__(config, *args, **kwargs)
		self.rpaplace = host_url
		self.cntrl_path_key = "cntrl_host"

	@property
	def target(self):
		cfg = self.config
		return f"{cfg['username']}@{self.rpaplace}"

	@property
	def main_conn_args(self):
		cfg = self.config
		username = cfg["username"]
		rpaserver = cfg["rpaserver"]
		cntrl_main = cfg["cntrl_main"]

		args = super().main_conn_args
		args.extend([
			f'-oProxyCommand="/usr/bin/ssh -W %h:%p {username}@{rpaserver} -oControlPath={cntrl_main}"',
			f"-oControlPath={cfg['cntrl_host']}",
			f"{cfg['username']}@{self.rpaplace}",
		])

		return args
nn_args
		args.extend([
			f'-oProxyCommand="/usr/bin/ssh -W %h:%p {username}@{rpaserver} -oControlPath={cntrl_main}"',
			f"-oControlPath={cfg['cntrl_host']}",
			f"{cfg['username']}@{self.rpaplace}",
		])

		return args
