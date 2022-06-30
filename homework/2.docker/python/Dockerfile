FROM python:3.9-slim

RUN pip install click==7.1.2
RUN pip install Flask==1.1.2
RUN pip install itsdangerous==1.1.0
RUN pip install Jinja2==2.11.2
RUN pip install MarkupSafe==1.1.1
RUN pip install Werkzeug==1.0.1
RUN apk add --no-cache wget

ADD . /app

WORKDIR app

RUN wget https://github.com/adterskov/geekbrains-conteinerization/blob/master/homework/2.docker/python/app.py

EXPOSE 8080

ENTRYPOINT python app.py runserver 0.0.0.0:8080
