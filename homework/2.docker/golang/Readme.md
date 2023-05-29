<h4>Создание образа:</h4>
# docker build . -t go-app:alpine-01</br>

<h4>Запуск образа:</h4>
# docker run -d -p 8080:8080 go-app:alpine-01</br>
41f3fb430252e902c571e98d71bbd5158709754fac6cc9d02273b68e86e94eb2</br>

<h4>Проверка:</h4>
# curl http://localhost:8080</br>
Hello, World!</br>
</br>

![image](https://user-images.githubusercontent.com/86831924/234957011-4391d77c-9cea-450e-8a4e-5313f2f2da52.png)
