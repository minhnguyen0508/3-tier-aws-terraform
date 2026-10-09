#!/bin/bash
mkdir -p /opt/app
cat > /opt/app/app.py <<'PY'
from http.server import BaseHTTPRequestHandler, HTTPServer
import socket

class H(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(f"Hello from the APP tier on {socket.gethostname()}\n".encode())

HTTPServer(("", 8080), H).serve_forever()
PY

cat > /etc/systemd/system/app.service <<'UNIT'
[Unit]
After=network.target
[Service]
ExecStart=/usr/bin/python3 /opt/app/app.py
Restart=always
[Install]
WantedBy=multi-user.target
UNIT

systemctl daemon-reload
systemctl enable --now app