# Установка базового образа Alpine Linux с Python 3.11
FROM python:3.11-alpine

# Установка рабочей директории внутри контейнера
WORKDIR /app

# Копирование зависимостей проекта
COPY requirements.txt .

# Установка зависимостей
RUN pip install --no-cache-dir -r requirements.txt

# Копирование исходных файлов проекта в контейнер
COPY . .

# Установка переменной окружения FLASK_APP
ENV FLASK_APP=app.py

# Установка порта, на котором будет работать приложение
EXPOSE 5000

# Запуск приложения при старте контейнера
CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]
