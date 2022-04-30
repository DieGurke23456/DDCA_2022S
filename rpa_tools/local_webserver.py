#import http.server
import json
import threading

from http.server import BaseHTTPRequestHandler, HTTPServer, HTTPStatus
from pathlib import PurePosixPath
from urllib.parse import unquote, urlparse, parse_qs


PORT = 8080
rpa_client = None


class RequestHandler(BaseHTTPRequestHandler):

    def log_message(self, format, *args):
        pass

    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Credentials', 'true')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, PUT, OPTIONS')
        self.send_header("Access-Control-Allow-Headers", "X-Requested-With, Content-type")
        super().end_headers()

    def do_OPTIONS(self):
        self.send_response(200, "ok")
        self.end_headers()

    def json_response(self, d):
        res = json.dumps(d)

        self.send_header("Content-type", "application/json")
        self.send_header("Content-Length", str(len(res)))
        self.end_headers()
        self.wfile.write(res.encode())

    def error_response(self, msg):
        self.send_response(HTTPStatus.INTERNAL_SERVER_ERROR)

        d = {"status": "error", "message": msg}
        self.json_response(d)

    def done_response(self, msg, data={}):
        self.send_response(HTTPStatus.OK)

        d = {"status": "ok", "message": msg}
        d.update(data)
        self.json_response(d)

    def need_rpa_client(fn):
        def wrapper(self, *args, **kwargs):
            global rpa_client
            if rpa_client is None:
                msg = "missing connection object, close connection and try again"
                self.error_response(msg)
            else:
                return fn(self, *args, **kwargs)
        return wrapper

    @need_rpa_client
    def do_PUT(self):
        request = urlparse(self.path)

        base, obj, *name = PurePosixPath(request.path).parts
        if base != "/":
            self.error_response("somhow path is not starting with '/'")
        elif obj.lower() == "streams":
            try:
                p = rpa_client.Place()
                p.getVideoStream(name[0]).open(rpa_client.config)
                self.done_response("stream opened")
            except IndexError:
                self.error_response(f"Stream name not valid: {' '.join(*name)}")
                self.respond_invalid_stream_arg(*name)
        else:
            self.error_response(f"'{obj}' is not a valid endpoint")

    @need_rpa_client
    def do_GET(self):
        global rpa_client

        try:
            ls = rpa_client.LockState
            data = {"streams": list(map(lambda vs: vs.name, ls.videostreams))}
            self.done_response("streams opened", data)
        except:
            self.error_response("failed to get videostreams")


class Webserver(threading.Thread):

    def __init__(self, bind_addr="localhost", port=8080, rpac=None):
        super().__init__(target=self.__class__)
        global rpa_client
        self.daemon = True

        server_address = (bind_addr, port)
        self.httpd = HTTPServer(server_address, RequestHandler)
        rpa_client = rpac

    def run(self):
        self.httpd.serve_forever()

    def setRPAClient(self, rpac):
        global rpa_client
        rpa_client = rpac
