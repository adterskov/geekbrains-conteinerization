FROM python:3.9-alpine

WORKDIR /app

ADD . /app

RUN python -m pip install --upgrade pip && \
    pip install -r requirements.txt

EXPOSE 8080

ENTRYPOINT python /app/app.py runserver 0.0.0.0:8080


