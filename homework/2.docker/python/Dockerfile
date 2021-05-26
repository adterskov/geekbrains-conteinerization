FROM python:3.9

#install dependences
RUN pip install Django==3.2

# add files from build directory to app
ADD . /app

EXPOSE 8080


ENTRYPOINT python /app/app.py