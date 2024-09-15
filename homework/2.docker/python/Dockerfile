FROM python:slim as builder

RUN pip install Flask
ADD app.py /

CMD [ "python", "./app.py" ]
