#!/usr/bin/env python3

import logging
import os
import signal
import threading
import tkinter
import webbrowser

from docopt import docopt
from tkinter import filedialog, ttk
from tkinter import font

from librpa import ConnectionStatus, PlaceState, RPAClient, RPAPlace, RPAStatus
from local_webserver import Webserver


usage_msg = """
GUI Frontend to lock a remote place in TILab and run webservers to
allow use of RPA-Webinterface

Usage:
  rpa_gui.py [--debug-log]
  rpa_gui.py -h | -v

Options:
  -h --help      Show this help screen
  -v --version   Show version information
  --debug-log    Print debugging messages to stdout
"""


class ExitSignalPublisher():
    def __init__(self):
        signal.signal(signal.SIGINT, self.handle_signal)
        signal.signal(signal.SIGTERM, self.handle_signal)

        self.subscribers = []

    def subscribe(self, subscriber):
        self.subscribers.append(subscriber)

    def handle_signal(self, *args):
        for subscriber in self.subscribers:
            subscriber.terminate()


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


class AlreadyConnectedFrame(ttk.Frame):
    def __init__(self, master):
        super().__init__(master, style="Choice.TFrame")
        self._connection_mode = tkinter.StringVar()

        notification_label = ttk.Label(self, text="Another process locked this host:", style="Choice.TLabel")
        sel_own = ttk.Radiobutton(self, text="Take ownership\n[disconnect will terminate all instances]", variable=self._connection_mode, value='own', style="Choice.TRadiobutton")
        sel_use = ttk.Radiobutton(self, text="Use established connection\n[disconnect won't influence other instances]", variable=self._connection_mode, value='use', style="Choice.TRadiobutton")
        confirm_button = ttk.Button(self, text="Confirm")

        self._connection_mode.set("own")

        notification_label.grid(column=1, row=1, pady=10)
        sel_own.grid(column=1, row=3, sticky=tkinter.W, pady=5, padx=15)
        sel_use.grid(column=1, row=4, sticky=tkinter.W, pady=5, padx=15)
        ttk.Frame(self).grid(column=1, row=5)
        confirm_button.grid(column=1, row=6, sticky=[tkinter.E, tkinter.S], padx=15, pady=15)

        self.rowconfigure(5, weight=1)
        self.rowconfigure(1, weight=1)

        confirm_button.bind("<Button>", lambda e: self.event_generate("<<ConfirmEstablishedConnection>>", data=self._connection_mode.get()))


class NewConnectionFrame(ttk.Frame):
    def __init__(self, master):
        super().__init__(master, style="Choice.TFrame")

        status_label = ttk.Label(self, text="Status: Disconnected", style="Choice.TLabel")
        msg_label = ttk.Label(self, text="Select a host to connect to", style="Choice.TLabel")
        connect_button = ttk.Button(self, text="Connect", style="Wireframe.TButton")

        status_label.grid(column=1, row=1, pady=25)
        msg_label.grid(column=1, row=2)
        ttk.Frame().grid(column=1, row=3)
        connect_button.grid(column=1, row=4, sticky=[tkinter.E, tkinter.S], padx=15, pady=15)

        self.rowconfigure(3, weight=1)
        self.columnconfigure(1, weight=1)

        connect_button.bind("<Button>", lambda e: self.event_generate("<<InitiateNewConnection>>"))


class ConnectedFrame(ttk.Frame):

    def _open_url(self):
        if self.webserver_url:
            webbrowser.open(self.webserver_url)

    def __init__(self, master):
        super().__init__(master, style="connected.TFrame")
        self.webserver_url = None
        self._placename = tkinter.StringVar()
        self._placename.set("Status: Connected")

        status_label = ttk.Label(self, textvar=self._placename, style="connected.TLabel")
        webgui_button = ttk.Button(self, text="Open web GUI", command=self._open_url, style="primary.TButton")
        disconnect_button = ttk.Button(self, text="Disconnect", style="warning.TButton")

        status_label.grid(column=1, row=1, pady=25)
        webgui_button.grid(column=1, row=2, columnspan=2, padx=15, sticky=[tkinter.W, tkinter.E])
        disconnect_button.grid(column=1, row=4, sticky=[tkinter.E, tkinter.S], padx=15, pady=15)

        self.rowconfigure(3, weight=1)
        self.columnconfigure(1, weight=1)

        disconnect_button.bind("<Button>", lambda e: self.event_generate("<<Disconnect>>"))

    def _set_webserver_url(self, url):
        self.webserver_url = url

    def _set_placename(self, name):
        self._placename.set(f"Status: Connected [{name}]")

    Placename = property(fset=_set_placename)
    WebserverURL = property(fset=_set_webserver_url)


class ProgressFrame(ttk.Frame):
    def __init__(self, master):
        super().__init__(master, style='Progress.TFrame')
        self.status = tkinter.StringVar()

        status_label = ttk.Label(self, textvar=self.status, style="Progress.TLabel")
        self.progressbar = ttk.Progressbar(self, orient=tkinter.HORIZONTAL, length=200, mode='indeterminate')

        status_label.grid(column=1, row=1, pady=25)
        self.progressbar.grid(column=1, row=3, padx=50, pady=25, sticky=[tkinter.W, tkinter.E])
        self.columnconfigure(1, weight=1)

    def setStatus(self, status):
        self.status.set(f"Status: {status}")

    def animateProgressbar(self, state):
        if state:
            self.progressbar.start()
        else:
            self.progressbar.stop()


class SideFrame(ttk.Frame):
    def __init__(self, master):
        super().__init__(master)


class ControlFrame(ttk.Frame):

    def __init__(self, master, streams):
        super().__init__(master)
        print(streams)

        # add videostreams
        # oscilloscope -> browser
        # open terminal
        # download .sof

        sof_name = tkinter.StringVar()

        self.sof_frame = ttk.Frame(self)
        self.sof_title = ttk.Label(self.sof_frame, text="Program board")
        self.sof_path_label = ttk.Label(self.sof_frame, text="Path:")
        self.sof_path = ttk.Entry(self.sof_frame, textvariable=sof_name)
        self.but_select_file = ttk.Button(self.sof_frame, text="Select File", command=lambda: sof_name.set(filedialog.askopenfilename()))
        #filename = filedialog.askopenfilename()
        self.but_download_sof = ttk.Button(self.sof_frame, text="Program", command=lambda: self.event_generate("<<ProgramBoard>>", data=sof_name.get()))

        self.sof_frame.grid()
        self.sof_title.grid(column=1, row=1, columnspan=3)
        self.sof_path_label.grid(column=1, row=3)
        self.sof_path.grid(column=2, row=3)
        self.but_select_file.grid(column=3, row=3)
        self.but_download_sof.grid(column=1, row=5, columnspan=3)

        self.streams_frame = ttk.Frame(self)
        self.title_label = ttk.Label(self.streams_frame, text="Open Streams:")
        for n, stream in enumerate(streams, 1):
            print(stream.name)
            button = ttk.Button(self.streams_frame, text=f"{stream.name}", command=stream.open)
            button.grid(column=n, row=2)
        button = ttk.Button(self.streams_frame, text="oszilloscope")

        self.title_label.grid(column=1, row=1, columnspan=n)
        self.streams_frame.grid()


class SettingsFrame(ttk.Frame):

    def processAction(self, event):
        action = event.widget.cget("text")

        d_changed = {}
        if action in ("Save", "Apply"):
            for n, (name, value) in enumerate(self.config.items(), 1):
                value_entry = getattr(self, f"var_{n}").get()
                if value_entry != value:
                    d_changed[name] = value_entry

            self.config.from_mapping(d_changed)

        logging.debug("changed:", self.config)

        if action == "Save":
            self.config.write_yml(self.path)

        self.event_generate("<<SettingsDone>>")

    def __init__(self, master, config, config_path):
        super().__init__(master, style="main.TFrame")
        self.config = config
        self.path = config_path

        ttk.Frame(self).grid(row=0, column=1, pady=2.5)

        for n, (name, value) in enumerate(config.items(), 1):
            ttk.Label(self, text=f"{name}:", style="main.TLabel").grid(row=n, column=1, sticky=tkinter.E, padx=5, pady=2)
            var = tkinter.StringVar()
            setattr(self, f"var_{n}", var)
            if value not in (None, "None"):
                var.set(value)
            ttk.Entry(self, textvariable=var).grid(row=n, column=2, columnspan=2, sticky=[tkinter.W, tkinter.E])

        f = ttk.Frame(self, style="main.TFrame")
        f.grid(row=n+1, column=1, columnspan=2, pady=15)

        for j, name in enumerate(("Cancel", "Apply", "Save")):
            btn = ttk.Button(f, text=name)
            btn.grid(row=1, column=j, padx=2)
            btn.bind("<Button>", self.processAction)

        self.columnconfigure(2, weight=1)

class HeaderFrame(ttk.Frame):
    def __init__(self, master, style=None):
        super().__init__(master, style="header.TFrame")
        self._title_text = tkinter.StringVar()

        title = ttk.Label(self, textvar=self._title_text, style="header.TLabel")
        self.settings = ttk.Button(self, text="settings", style="Settings.TButton")
        title.grid(row=1, column=1)
        self.settings.grid(row=1, column=1, sticky=[tkinter.N, tkinter.E, tkinter.S])

        self.settings.bind("<Button>", lambda e: self.event_generate("<<SettingsClicked>>"))

        self.columnconfigure(1, weight=1)

    def _set_title(self, text):
        self._title_text.set(text)

    def _show_button(self, state: bool):
        if state:
            self.settings.grid()
        else:
            self.settings.grid_remove()

    Title = property(fset=_set_title)
    ShowButton = property(fset=_show_button)


class MainFrame(ttk.Frame):

    def __init__(self, master):
        super().__init__(master, style="main.TFrame")

        self._hostlist = tkinter.StringVar()

        self.hostlistbox = tkinter.Listbox(self, listvariable=self._hostlist, foreground="#d0d0d0", selectbackground="#708090", background="#405060", relief="solid", borderwidth=1, highlightthickness=0)
        self.sf = None

        self.hostlistbox.grid(column=1, row=1, padx=15, pady=15)

        min_width = 350  # self.options.winfo_width()
        self.columnconfigure(2, minsize=min_width)

        self.sideframes = {
            "NewConnection": NewConnectionFrame(self),
            "Connected": ConnectedFrame(self),
            "AlreadyConnected": AlreadyConnectedFrame(self),
            "Progress": ProgressFrame(self),
        }

    def _side_frame(self, name: str):
        if self.sf:
            if self.sf == self.sideframes["Progress"]:
                self.sf.animateProgressbar(False)
            self.sf.grid_remove()

        self.sf = self.sideframes[name]
        if name == "Progress":
            self.sf.animateProgressbar(True)
        self.sf.grid(column=2, row=1, sticky=[tkinter.W, tkinter.N, tkinter.E, tkinter.S], padx=15, pady=15)

        min_width = 400  # self.options.winfo_width()
        self.columnconfigure(2, minsize=min_width)

    def setProgressStatus(self, status):
        self.sideframes["Progress"].setStatus(status)

    def _set_hostlist(self, hostList: [str]):
        self.hl = hostList
        self._hostlist.set(self.hl)

    def _host_select_enabled(self, state: bool):
        if state is True:
            self.hostlistbox.configure(state="normal")
        else:
            self.hostlistbox.configure(state="disable")

    @property
    def SelectedPlaceIdx(self):
       return self.hostlistbox.curselection()[0]


    sideFrame = property(fset=_side_frame)
    hostList = property(fset=_set_hostlist)
    hostSelectEnabled = property(fset=_host_select_enabled)


class View():

    def missingSettingsDialog(self, config, config_path):
        _username = tkinter.StringVar()
        _identity = tkinter.StringVar()
        if config.get("username") is not None:
            _username.set(config.get("username"))

        def close():
            # eh, somebody wants to close me, do nothing :o
            config["username"] = _username.get()
            config["identity"] = _identity.get() if len(_identity.get()) else None
            config.write_yml(config_path)
            dlg.grab_release()
            dlg.destroy()

        dlg = tkinter.Toplevel(self.root)
        ttk.Label(dlg, text="Some settings are missing:").grid(pady=15)

        container = ttk.Frame(dlg)

        ttk.Label(container, text="tilab username:").grid(row=2, column=1)
        ttk.Entry(container, textvar=_username).grid(row=2, column=2, sticky=[tkinter.W, tkinter.E])

        ttk.Frame(container).grid(row=3, pady=10)

        default_identity = os.path.expanduser("~/.ssh/id_rsa")
        if os.path.exists(default_identity):
            _identity.set(default_identity)
            ttk.Label(container, text="Autodetected SSH-Keys:").grid(row=4, column=1, columnspan=3, padx=5)
        else:
            ttk.Label(container, text="Did you generate an ssh-key? Check the tutorial in TUWEL!").grid(row=4, column=1, columnspan=3)
        ttk.Label(container, text="ssh private key:").grid(row=5, column=1)
        ttk.Entry(container, textvar=_identity).grid(row=5, column=2, sticky=[tkinter.W, tkinter.E])
        ttk.Button(container, text="open", command=lambda: _identity.set(filedialog.askopenfilename())).grid(row=5, column=3, padx=5)
        container.columnconfigure(2, minsize=300)
        container.grid(padx=10, pady=10)
        ttk.Button(dlg, text="Ok", command=close).grid()


        dlg.protocol("WM_DELETE_WINDOW", close) # intercept close button
        dlg.transient(self.root)   # dialog window is related to main
        dlg.wait_visibility() # can't grab until window appears, so we wait
        dlg.grab_set()        # ensure all input goes to our window
        dlg.wait_window()     # block until window is destroyed

    def infoBox(self, msg):
        def close():
            dlg.grab_release()
            dlg.destroy()

        dlg = tkinter.Toplevel(self.root)
        ttk.Label(dlg, text="There was an error:").grid(row=1, column=2, pady=10)
        ttk.Label(dlg, text=msg).grid(row=2, column=2, padx=10)
        ttk.Button(dlg, text="Ok", command=close).grid(row=5, column=2, pady=10)
        dlg.protocol("WM_DELETE_WINDOW", close) # intercept close button
        dlg.transient(self.root)   # dialog window is related to main
        dlg.wait_visibility() # can't grab until window appears, so we wait
        dlg.grab_set()        # ensure all input goes to our window
        dlg.wait_window()     # block until window is destroyed

    def __init__(self):
        self.root = tkinter.Tk()

        # set styles
        s = ttk.Style()
        s.configure('header.TFrame', foreground='#c0c0c0', background='#404040', borderwidth=1, relief='raised')
        s.configure("header.TLabel", foreground="white", background="#404040")

        s.configure("main.TFrame", foreground="white", background="#506070")
        s.configure("main.TLabel", foreground="white", background="#506070")

        s.configure("connected.TFrame", background="#60a060", borderwidth=2, relief="solid")
        s.configure("connected.TLabel", foreground="white", background="#60a060")

        background_red = [('!active', '#d04040'), ('pressed', 'green'), ('active', '#e06060')]
        s.configure("warning.TButton", foreground="white", borderwidth=2, relief='raised')
        s.map("warning.TButton", background=background_red)
        background_blue = [('!active', '#5050b0'), ('pressed', 'green'), ('active', '#6060c0')]
        s.configure("primary.TButton", foreground="white", borderwidth=2, relief='raised')
        s.map("primary.TButton", background=background_blue)

        s.configure('Progress.TFrame', foreground="white", background='#504060', borderwidth=2, relief='solid')
        s.configure('Progress.TLabel', foreground="white", background='#504060', borderwidth=0, relief='raised')

        s.configure('Choice.TFrame', foreground="white", background='#405060', borderwidth=2, relief='solid')
        s.configure('Choice.TLabel', foreground="white", background='#405060', borderwidth=0, relief='raised')
        background_choice = [('!active', '#405060'), ('pressed', '#607080'), ('active', '#607080')]

        common_fg = "white" 
        common_bg = "#b55612"

        s.configure('Choice.TRadiobutton', foreground="white", borderwidth=0, relief='raised')
        s.map("Choice.TRadiobutton", foreground=[('!active', common_fg), ('pressed', common_fg), ('active', common_fg)],
                                     background=background_choice,
                                     indicatorcolor=[('selected', common_bg), ('pressed', common_bg)])

        background_wireframe = [('!active', '#506070'), ('pressed', '#708090'), ('active', '#708090')]
        s.configure('Wireframe.TButton', foreground="white", borderwidth=2, relief="solid")
        s.map("Wireframe.TButton", background=background_wireframe)

        background_settings = [('!active', '#404040'), ('pressed', '#606060'), ('active', '#606060')]
        s.configure('Settings.TButton', foreground="white", borderwidth=1, relief="raised")
        s.map("Settings.TButton", background=background_settings)


        self.root.title("Remote Place Assigner")
        self.root.resizable(False, False)

        # TODO: scale font for HDPI displays
        # print("pixels per inch=" + str(root.winfo_pixels('1i')))

        self.hf = HeaderFrame(self.root)
        self.hf.grid(column=1, row=0, sticky=[tkinter.W, tkinter.N, tkinter.E, tkinter.S])
        self.hf.Title = "RPA GUI"

        self.mw = MainFrame(self.root)
        self.mw.grid(column=1, row=1)

        min_height = 30
        self.hf.rowconfigure(1, minsize=min_height)
        self.hf.rowconfigure(0, weight=1)

    def timer(self, timeout, callback):
        self.root.after(timeout, callback)

    def updateHostList(self, hostList: [str]):
        self.mw.hostList = hostList
        #hostname = self.hosts[self.hostlistbox.curselection()[0]].name

    def destroy(self):
        self.root.destroy()

    @property
    def SelectedPlaceIdx(self):
        return self.mw.SelectedPlaceIdx

    def _set_webserver_url(self, url):
        self.mw.sideframes["Connected"].WebserverURL = url

    def _set_placename(self, name):
        self.mw.sideframes["Connected"].Placename = name

    def run(self):
        self.root.update()
        size = (self.root.winfo_width(), self.root.winfo_height())
        self.root.minsize(*size)

        self.root.mainloop()

    def setProgressStatus(self, status):
        self.mw.setProgressStatus(status)

    def _host_select_enabled(self, value: bool):
        self.mw.hostSelectEnabled = value

    def _side_frame(self, frame: str):
        self.mw.sideFrame = frame
        self.hf.ShowButton = frame in ("NewConnection", "AlreadyConnected")

    def bindEvent(self, event, cb, data=False):
        if data:
            cmd = self.root.register(cb)
            self.root.tk.call("bind", self.root, event, f"{cmd} %d")
        else:
            self.root.bind(event, cb)

    def event(self, *args, **kwargs):
        self.root.event_generate(*args, **kwargs)

    def showSettings(self, config, config_path):
        self.hf.Title = "Settings"
        self.hf.ShowButton = False
        self.sw = SettingsFrame(self.root, config, config_path)
        self.sw.grid(column=1, row=1, sticky=[tkinter.W, tkinter.N, tkinter.E, tkinter.S])
        self.root.rowconfigure(1, weight=1)
        self.root.columnconfigure(1, weight=1)

    def hideSettings(self):
        self.sw.grid_forget()
        self.hf.Title = "RPA GUI"
        self.hf.ShowButton = True
        self.sw.grid_forget()
        self.mw.grid()

    hostSelectEnabled = property(fset=_host_select_enabled)
    sideFrame = property(fset=_side_frame)
    Placename = property(fset=_set_placename)
    WebserverURL = property(fset=_set_webserver_url)


class Model():
    def __init__(self):
        self.c = RPAClient(__name__)
        self.config_path = "./rpa_cfg.yml"
        try:
            self.c.config.from_yml(self.config_path)
        except FileNotFoundError:
            pass
        self.c.config["_keyonly_auth"] = True

        self.places = None
        self.lockstate = None
        self.cs = None
        self.p = None

    @property
    def refreshPlaceList(self):
        self.places = self.c.Places

    @property
    def refreshConnectionStatus(self):
        self.lockstate = self.c.LockState
        self.cs = ConnectionStatus.from_response(self.lockstate)

    @property
    def releasePlace(self):
        self.c.releasePlace()

    def getPlace(self, name=None):
        self.p = self.c.Place(name)

    def forwardOscillosopePorts(self):
        # TODO: assuming that (local) ports are available
        self.p.addPortForwarding(8082, "203.0.113.2", 80)
        self.p.addPortForwarding(5850, "203.0.113.2", 5850)

    def runWebserver(self):
        # TODO: assuming that port is available - otherwise OSError is thrown
        def webserver():
            self.p.runCommand(["python3", "/opt/ddca/bin/webserver/webserver.py", "-P", "8081", "-L", "8080", "-r", "/opt/ddca/bin/webserver/webroot", "-S", "/opt/ddca/bin/webserver/sof"])

        t = threading.Thread(target=webserver, name="webserver")
        t.start()

        # TODO: assuming that port is available
        self.p.addPortForwarding(8081, "127.0.0.1", 8081)

    @property
    def ConnectionStatus(self):
        return self.cs

    @property
    def PlaceList(self):
        names = []
        for place in self.places:
            s = "  "
            if place.state == PlaceState.LOCKED:
                if place.name == self.cs.name:
                    s += "[assigned]"
                else:
                    s += "[locked]"
            elif place.state == PlaceState.FREE:
                s += "[free]"
            else:
                s += "[unknown]"
            s += f" {place.name}"
            names.append(s)

        return names

    def getPlaceByIdx(self, idx):
        return self.places[idx]

    @property
    def Videostreams(self):
        self.p = self.c.Place()
        return self.p.videostreams

    @property
    def Placename(self):
        if self.p:
            return self.p.name
        else:
            return ""

    def _take_over(self, state: bool):
        self.c.rpa_main = state

    TakeOver = property(fset=_take_over)


class RPAEventHandlerThread(threading.Thread):
    def __init__(self, queue, cb_msg_update):
        super().__init__(target=self.__class__)
        self.queue = queue
        self.cb_msg_update = cb_msg_update
        self.daemon = True

    def run(self):
        while True:
            r = self.queue.get()
            if r.status == RPAStatus.WAITING:
                self.cb_msg_update("Connecting - in wait queue")


# TODO: add refresh button to update usage of hosts
# TODO: use background-thread to query for state-changes

class Controller():
    def __init__(self, esp: ExitSignalPublisher):
        # TODO:  does not work, tkinter must run in seperate thread...
        #esp.subscribe(self)

        # local webserver
        self.ws = Webserver()
        self.ws.start()

        self.v = View()
        self.m = Model()

        # update progress message
        ev_thread = RPAEventHandlerThread(self.m.c.RPAEventQueue, self.v.setProgressStatus)
        ev_thread.start()

        self.v.bindEvent("<<Disconnect>>", self.callbackDisconnect)
        self.v.bindEvent("<<ConfirmEstablishedConnection>>", self.callbackConfirmConnected, data=True)
        self.v.bindEvent("<<InitiateNewConnection>>", self.callbackInitiateNewConnection)
        self.v.bindEvent("<<RPAConnected>>", self.callbackRPAConnected)
        self.v.bindEvent("<<PlaceReady>>", self.callbackPlaceReady, data=True)
        self.v.bindEvent("<<RPADisconnected>>", self.callbackRPADisconnected)
        self.v.bindEvent("<<SettingsDone>>", self.callbackSettingsDone)
        self.v.bindEvent("<<SettingsClicked>>", self.callbackSettingsClicked)
        self.v.bindEvent("<<RefreshMainScreen>>", self.showMainScreen, data=True)

        def mainScreenRefreshTimer(refresh_allowed):
            import time
            time.sleep(2)  # TODO: wait for Tk loop to run
            while True:
                time.sleep(0.5)
                if refresh_allowed.is_set():
                    try:
                        self.v.event("<<RefreshMainScreen>>", data=False)
                    except RuntimeError:
                        break  # Tk windows gone

        self.refresh_allowed = threading.Event()
        #t_refresh = threading.Thread(target=mainScreenRefreshTimer, args=(self.refresh_allowed, ))
        #t_refresh.daemon = True
        #t_refresh.start()

        # check if username, identity is present
        if any(map(lambda key: self.m.c.config.get(key, None) in (None, ""), ("username", "identity"))):
            self.v.missingSettingsDialog(self.m.c.config, self.m.config_path)
        #else:
        self.showMainScreen()

    def terminate(self):
        # TODO: fix with tkinter loop in seperate thread
        #self.v.destroy()
        self.m.c.terminate()

    # call repeatedly until Connect button is clicked
    def showMainScreen(self, autorefresh=True):
        #if autorefresh:
        #    self.refresh_allowed.set()
        #else:
        #    self.refresh_allowed.clear()

        try:
            self.m.refreshPlaceList
            self.m.refreshConnectionStatus
            self.v.updateHostList(self.m.PlaceList)
            self.updateInterface()
        except Exception as e:
            self.refresh_allowed.clear()
            self.v.showSettings(self.m.c.config, self.m.config_path)
            # TODO: improve error messages
            self.v.infoBox(e)

    def callbackSettingsDone(self, event):
        self.v.hideSettings()
        self.showMainScreen()
        self.updateInterface()

    def callbackSettingsClicked(self, event):
        self.refresh_allowed.clear()
        self.v.showSettings(self.m.c.config, self.m.config_path)

    def callbackDisconnect(self, ev):
        self.v.setProgressStatus("Disconnecting")
        self.v.sideFrame = "Progress"

        t = threading.Thread(target=self.disconnect, name="disconnect")
        t.start()

    def callbackRPADisconnected(self, event):
        self.showMainScreen()

    def updateInterface(self):
        cs = self.m.ConnectionStatus
        if cs == ConnectionStatus.ASSIGNED:
            self.v.hostSelectEnabled = False
            self.v.sideFrame = "AlreadyConnected"
        elif cs == ConnectionStatus.UNASSIGNED:
            self.v.hostSelectEnabled = True
            self.v.sideFrame = "NewConnection"
        else:
            pass
            #self.v.hostSelectEnabled = False
            #self.v.sideFrame = "NewConnection"
            #self.v.sideFrame = InvalidStateFrame

    def disconnect(self):
        try:
            self.m.releasePlace
            self.m.refreshConnectionStatus
            self.m.refreshPlaceList
            self.v.updateHostList(self.m.PlaceList)
        except Exception as e:
            # TODO: for now, just use the hammer and destroy all connections
            self.m.c.terminate()
            self.v.infoBox(e)
            logging.debug(f"Error while disconnecting: {e}")
        finally:
            self.v.event("<<RPADisconnected>>")

    def callbackConfirmConnected(self, choice: str):
        self.refresh_allowed.clear()
        self.v.setProgressStatus("Connecting")
        self.v.sideFrame = "Progress"
        self.m.TakeOver = True if choice == "own" else False

        t = threading.Thread(target=self.connect, name="connect")
        t.start()

    def callbackInitiateNewConnection(self, name: str):
        self.refresh_allowed.clear()
        self.v.setProgressStatus("Connecting")
        self.v.sideFrame = "Progress"
        self.m.TakeOver = True

        t = threading.Thread(target=self.connect, name="connect")
        t.start()

    def callbackRPAConnected(self, event):
        self.refresh_allowed.clear()

        self.v.setProgressStatus("Preparing place")
        t = threading.Thread(target=self.prepare_place, name="prepare place")
        t.start()

    def prepare_place(self):
        # install software
        self.m.p.runCommand(["pip3", "install", "--user", "aiohttp[speedups]"], quiet=True)

        # start webserver
        # TODO - choose port, wait for succcess
        self.m.runWebserver()
        self.v.event("<<PlaceReady>>")

    def callbackPlaceReady(self, event):
        self.v.WebserverURL = "http://localhost:8081"
        self.v.Placename = self.m.Placename
        self.ws.setRPAClient(self.m.c)
        try:
            self.m.forwardOscillosopePorts()
            self.v.hostSelectEnabled = False
            self.v.sideFrame = "Connected"
            self.refreshConnectedScreen()
        except OSError as e:
            # failed to bind, ports in use. oscilloscope probably not accessible
            self.v.infoBox(f"Failed to forward oscilloscope ports: {e}")
            self.m.c.terminate()
            self.v.event("<<RPADisconnected>>")

    def refreshConnectedScreen(self):
        # TODO fix
        return
        try:
            self.m.refreshPlaceList
            self.v.updateHostList(self.m.PlaceList)
            self.m.refreshConnectionStatus
            # TODO: it would be faster to use status from queue!
            if self.m.ConnectionStatus != ConnectionStatus.ASSIGNED:
                logging.debug("terminating on refresh")
                self.m.c.terminate()
                self.v.event("<<RPADisconnected>>")
            else:
                self.v.timer(500, self.refreshConnectedScreen)
        except Exception as e:
            logging.debug(f"exception encountered: {e}")
            self.m.c.terminate()
            self.v.event("<<RPADisconnected>>")

    def run(self):
        self.v.run()

        # gui exited, do cleanup
        self.terminate()

    def connect(self):
        try:
            name = self.m.getPlaceByIdx(self.v.SelectedPlaceIdx).name
        except IndexError:
            name = None

        # if locking given place fails:
        # * close all connections
        # * revert to start-screen (choose a host again)
        # * show error message
        try:
            self.m.getPlace(name)
            self.v.event("<<RPAConnected>>")
        except Exception as e:
            logging.debug(f"failed to get place! {e}")
            self.m.c.terminate()  # release connections by terminating
            self.v.event("<<RPADisconnected>>")
            self.v.infoBox(e)


#root.bind('<Return>', lambda e: action.invoke())
#root.bind('<Escape>', lambda e: action.invoke())


if __name__ == '__main__':
    options = docopt(usage_msg, version="1.2.1")

    esp = ExitSignalPublisher()

    if options["--debug-log"]:
        configure_logger()

    c = Controller(esp)
    c.run()
