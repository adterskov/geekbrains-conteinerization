FROM ubuntu:16.04

#ENV PYTHONUNBUFFERED 1

EXPOSE 8080

ADD python ./python

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.5 \
    python3-pip \
    && \
apt-get clean

RUN pip3 install -r /python/requirements.txt

WORKDIR /python

CMD python3 app.py
