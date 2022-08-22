FROM python:3.10-alpine as builder
WORKDIR /usr/src/app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /usr/src/app/wheels -r requirements.txt

# FINAL
FROM python:3.10-alpine
RUN mkdir -p /home/app
RUN addgroup --system app && adduser -S -G app app
RUN pip install --upgrade pip
ENV APP_HOME=/home/app/web
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
COPY --from=builder /usr/src/app/wheels /wheels
COPY --from=builder /usr/src/app/requirements.txt .
#RUN pip install --no-cache /wheels/*
RUN pip install --no-index --find-links=/wheels/ -r requirements.txt
COPY . $APP_HOME
RUN chown -R app:app $APP_HOME
USER app
EXPOSE 8080
ENTRYPOINT python app.py
