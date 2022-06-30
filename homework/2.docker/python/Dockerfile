FROM python:3.9-slim

RUN pip install --proxy=http://10.31.80.2:3128 click==7.1.2
RUN pip install --proxy=http://10.31.80.2:3128 Flask==1.1.2
RUN pip install --proxy=http://10.31.80.2:3128 itsdangerous==1.1.0
RUN pip install --proxy=http://10.31.80.2:3128 Jinja2==2.11.2
RUN pip install --proxy=http://10.31.80.2:3128 MarkupSafe==1.1.1
RUN pip install --proxy=http://10.31.80.2:3128 Werkzeug==1.0.1

ADD . .

EXPOSE 8080

ENTRYPOINT python app.py runserver 0.0.0.0:8080
