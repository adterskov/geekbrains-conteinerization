#!/usr/bin/env python

import os

from flask import Flask

config = {
        "debug": os.environ.get('DEBUG', True)
}

app = Flask(__name__)

@app.route("/")
def hello():
    return "Hello, World!"

if __name__ == "__main__":
    app.run(debug=config["debug"])
