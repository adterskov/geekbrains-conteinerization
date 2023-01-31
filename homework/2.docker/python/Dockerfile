FROM python:alpine3.16

COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

ADD app.py /

EXPOSE 8080

ENTRYPOINT python app.py
