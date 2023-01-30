# Использование команд RUN, COPY и ADD приводит к созданию слоёв.
FROM python:3.9
WORKDIR /app
# Используйте команду COPY, если вам не нужны дополнительные возможности ADD
# Скопируем только файл с переменными для установки пакетов,
# т.к. эти зависимости меняются НЕ часто, в отличии от app.py
# Т.о., при изменении файла app.py, у нас не будут устанавливаться
# пакеты из requirements.txt
COPY requirements.txt .
# Добавим кеширование устанавливаемы пакетов
RUN --mount=type=cache,target=.cache/pip \
        pip install -r requirements.txt
COPY app.py .
EXPOSE 8080
ENTRYPOINT python3 app.py