FROM python:3.9.16-slim

COPY ./python/requirements.txt /app/

RUN  pip3 install -r /app/requirements.txt --disable-pip-version-check

ADD ./python/app.py /app

EXPOSE 8080

ENTRYPOINT python3 /app/app.py


