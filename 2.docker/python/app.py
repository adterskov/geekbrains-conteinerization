#!/usr/bin/env python

import os

from flask import Flask

config = {
        "port": os.environ.get('PORT', 8080),
        "debug": os.environ.get('DEBUG', False)
}

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello, World!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=config["port"], debug=config["debug"])
