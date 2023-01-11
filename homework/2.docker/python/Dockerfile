FROM python:3.11

MAINTAINER Maxim Soloviov
LABEL version="1.0"

WORKDIR /app
COPY . /app
RUN pip install -r /app/requirements.txt

EXPOSE 8080

ENTRYPOINT ["python"]
CMD ["/app/app.py", "runserver", "0.0.0.0:8080"]
