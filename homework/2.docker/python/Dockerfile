FROM python:3.6.8-jessie

ENV PYTHONUNBUFFERED 1

ADD python ./

WORKDIR /python

ADD requirements.txt .
RUN pip install -r requirements.txt

CMD /bin/sh docker-entrypoint.sh
