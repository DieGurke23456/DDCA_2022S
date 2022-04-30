#!/usr/bin/env python3

from librpa import RPAStatus, RPAClient, ConnectionStatus

from dataclasses import dataclass, field
from datetime import datetime
from docopt import docopt
from enum import Enum
from time import sleep

import atexit
import logging
import os
import subprocess
import threading


def configure_logger():
    logger = logging.getLogger()
    logger.setLevel(logging.DEBUG)

    # create console handler and set level to debug
    ch = logging.StreamHandler()
    ch.setLevel(logging.DEBUG)

    # create formatter
    formatter = logging.Formatter('%(asctime)s, %(filename)s:%(lineno)d::%(threadName)s - %(name)s - %(levelname)s - %(message)s')

    # add formatter to ch
    ch.setFormatter(formatter)

    # add ch to logger
    logger.addHandler(ch)

    return logger


#--------|#--------|#--------|#--------|#--------|#--------|#--------|#--------|
usage_msg = """
This tool simplifies the access to the remote lab environment in the TILab. The
first call to rpa_shell (master process) automatically acquires a lab PC slot
and optionally opens the video streams, programs the FPGA, executes a command or
opens an interactive shell. Subsequent executions of rpa_shell will use the same
connection as long as the lab PC is assigned to you or until you terminate the
master process. For that matter rpa_shell may also be executed and used on
different machines simultaneously, e.g., in a VM and the host system.

If neither -n nor a command (<CMD>) is specified, rpa_shell opens an interactive
shell by default. If -n is supplied to the master process a simple menu will be
shown, that waits for user input. This menu also shows a list of the supported
video streams.

To access the TILab computers you have to specify your username. You can do this
via the -u argument or using a config file named 'rpa_cfg.yml' which must be
placed in the same directory as the rpa_shell script itself. To create this file
simply execute rpa_shell without a username and follow the instructions.

Optionally you can also specify which identity file (i.e., private key file) the
rpa_shell tool should use to establish the SSH connection (-i argument passed to
the ssh command). You can do this via the -i command line option or using the
(optional) identity entry in the config file. If you don't know what this
feature is for, you will probably not need it. To specify an identity add the
following line to the config file:

identity: PATH_TO_YOUR_IDENTITY_FILE

The config file may also contain an (optional) entry named 'stream_cmd' to
precisely specify the command that should be used to open the streams. The
default command is:
  ffplay -fflags nobuffer -flags low_delay -framedrop -hide_banner \\
         -loglevel error -autoexit
This command ensures a low latency stream. Another possibility is to use the VLC
player instead.

Usage:
  rpa_shell.py [-c HOST -p SOF -u USER -i ID -d] [-a | -s STREAM] [-n | <CMD>] [--take-over | --no-master] [--debug-log]
  rpa_shell.py [-u USER -i ID -t] [--debug-log]
  rpa_shell.py --scp [-u USER -i ID] <LOCAL_SRC> [<REMOTE_DEST>] [--debug-log]
  rpa_shell.py -h | -v

Options:
  -h --help      Show this help screen
  -v --version   Show version information
  -n --no-shell  Don't open a shell.
  -c HOST        Request access to a specific host.
  -t             Show status information about the rpa system, i.e., available
                 hosts usage, etc. (executes rpa status and shows the result).
  -a             Open all video streams
  -s STREAM      Open one particular stream (e.g., target)
  -p SOF         Download the specified SOF_FILE file to the FPGA board.
  -u USER        The username for the SSH connection. If omitted the username
                 must be contained in the rpa_cfg.yml config file.
  -i ID          The identity file to use for the SSH connection.
  -d             Video stream debug mode (don't redirect the stream player's
                 output to /dev/null)
  --scp          Copies the file specified by <LOCAL_SRC> to the lab, at the
                 location specified by <REMOTE_DEST>. If <REMOTE_DEST> is
                 omitted the file will be placed in your home directory.
  --take-over    If a master session is already established it will be taken
                 over, leaving the previous master as normal shell. Otherwise
                 it will be without effect.
  --no-master    Create a session only if there is a master session established.
  --debug-log    Log debug messages to cli.
"""


def interactive_ui(c, is_main):
	action = None

	stream_msgs = []
	stream_key_map = {}
	p = c.Place()

	idx = 1
	for vs in p.videostreams:
		stream_msgs += ["  " + str(idx) + ": open video stream '" + vs.name + "'"]
		stream_key_map[str(idx)] = vs
		idx += 1

	stream_msg = "\n".join(stream_msgs)
	conn_type = "master" if is_main else "client"

	while (True):
		r = c.LockState
		os.system("clear")
		msg = f"""\
This is the {conn_type} process for your connection to {c.Place().name}.
{"Terminating this process will terminate ALL open connections to this host." if is_main else ""}
Your lock expires at {r.deadline}.
Available commands:
  i: open interactive shell
{stream_msg}
  q: quit {"(terminates all open connections)" if is_main else ""}\
"""

		print(msg)
		print("Enter command >> ", end="", flush=True)
		r = subprocess.run("read -t 1 -N 1; echo $REPLY", shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
		action = r.stdout.decode("utf-8").strip()

		if(action == "q"):
			print()
			break
		if(action == "i"):
			print()
			p.runShell()

		if (action in stream_key_map):
			stream_key_map[action].open(c.config)


def ask_for_username(c: RPAClient, cfg_file: str):
	write = False

	print("You did not specify a TILab username!")
	username = input("Enter your username: ")
	while(True):
		response = input("Do you want me to create a config file and add this username? [y/n] ")
		response = response.strip().lower()

		if response in ["y", "n"]:
			if response == "y":
				write = True
			break
		print("Invalid response, type 'y' or 'n'!")

	c.config["username"] = username
	if write:
		c.config.write_yml(cfg_file)


class RPAEventHandlerThread(threading.Thread):
	def __init__(self, queue):
		super().__init__()
		self.daemon = True
		self.queue = queue

	def run(self):
		while True:
			rpa_response = self.queue.get()

			if rpa_response.status == RPAStatus.ASSIGNED:
				pass
			elif rpa_response.status == RPAStatus.WAITING:
				print("No free host available, you have been added to the waiting queue!")
			elif rpa_response.status == RPAStatus.EXTENDED:
				print("deadline has been extended to {rpa_response.deadline}!")
			elif rpa_response.status == RPAStatus.INFO:
				print(rpa_response.reason)
			elif rpa_response.status == RPAStatus.REPLACE:
				print("Replaced existing connection!")
			elif rpa_response.status == RPAStatus.BYE:
				print("\r\nAnother process is master now!")
				print("\rYou may close this terminal without losing your lock and streams.\r")
			else:
				print(f"{rpa_response.status}: {rpa_response.reason}")


def evaluate_status(status, options, config):
	is_main_process = False

	if status == ConnectionStatus.QUEUED:
		print("You already have an instance running waiting for a lock")
		c.terminate()
		exit(1)
	elif status == ConnectionStatus.UNASSIGNED and options["--no-master"]:
		print("No master connection found, create one before trying again")
		c.terminate()
		exit(1)
	elif status == ConnectionStatus.UNASSIGNED or (status == ConnectionStatus.ASSIGNED and options["--take-over"]):
		is_main_process = True
	elif status == ConnectionStatus.ASSIGNED:
		is_main_process = False
	else:
		print("unknown status, exiting")
		c.terminate()
		exit(1)

	return is_main_process


def main():
	options = docopt(usage_msg, version="1.2.1")
	if options["--debug-log"]:
		configure_logger()
	cfg_file = "rpa_cfg.yml"

	with RPAClient(__name__) as c:
		atexit.register(lambda c: c.terminate(), c)  # close connections
		# TODO: register CTRL + C

		try:
			c.config.from_yml(cfg_file)
		except FileNotFoundError:
			pass

		if os.path.exists(os.path.expanduser(c.config["cntrl_main"])) and options["--take-over"]:
			print("""\
Can't take over local main connection as you are running already a main ssh connection.
This can also happen if several users use the same control path (e.g. /tmp/<name>).
In this case, change the paths in the config file.""")
			exit(1)

		c.config.from_mapping({"identity": options["-i"], "username": options["-u"]}, ignore_none=True)
		if c.config["username"] is None:
			ask_for_username(c, cfg_file)
		c.config["debug_streams"] = options["-d"]

		if(options["-t"]):
			print(c.Places)
			exit(0)

		if (options["--scp"]):
			dest = options.get("<REMOTE_DEST>", "")
			c.putFile(options["<LOCAL_SRC>"], dest)
			exit(0)

		if os.path.exists(os.path.expanduser(c.config["cntrl_main"])):
			is_main_process = False
			c.rpa_main = False
			status = c.ConnectionStatus
			evaluate_status(status, options, c.config)
		else:
			status = c.ConnectionStatus
			is_main_process = evaluate_status(status, options, c.config)
			if not is_main_process:
				c.rpa_main = False

		t_event_handler = RPAEventHandlerThread(c.RPAEventQueue)
		t_event_handler.start()
		p = c.Place(options["-c"])

		if options["-p"] is not None:
			sof_file = os.path.basename(options["-p"])
			c.runCommand(["mkdir", "-p", "~/.rpa_shell", "&&", "rm", "-f", "~/.rpa_shell/*.sof"])
			c.putFile(options["-p"], ".rpa_shell/")
			p.program(sof_file)
			exit(0)

		if options["-a"]:
			sleep(0.5)
			for vs in p.videostreams:
				print("opening stream " + vs.name + ": " + vs.url)
				vs.open(c.config)

		if options["-s"] is not None:
			name = options["-s"]
			url = p.getStreamURL(name)
			if url is None:
				print(name + " does not identify a stream")
			else:
				print("opening stream " + name + ": " + url)
				p.getVideoStream(name).open(c.config)

		if options["<CMD>"] is not None:
			cmd = p.runCommand(options["<CMD>"], ssh_args=["-tt"], shell=True)
		elif not options["--no-shell"]:
			if is_main_process:
				print(
"""\
>>> Close the shell using Ctrl+D or by executing 'exit'. <<<
>>> CAUTION: This is the master process! <<<
>>> Closing this shell will terminate all open connections! <<<\
""")
			else:
				print(">>> Close the shell using Ctrl+D or by executing 'exit' <<<")
			p.runShell()

		if options["--no-shell"]:
			logging.debug("starting interacte shell")
			interactive_ui(c, is_main_process)


if __name__ == "__main__":
	try:
		main()
	except TypeError as e:
		# could also be an invalid response from rpa server
		# but it's much more likely that the main connection
		# went down while connecting
		if "'NoneType' object is not subscriptable" in e.args:
			print("Lost main connection, try again!")
		else:
			raise
	except ValueError as e:
		print(''.join(e.args))
t("Lost main connection, try again!")
		else:
			raise
	except ValueError as e:
		print(''.join(e.args))
