
Домашнее задание для к уроку 8 - CI/CD

В рамках данного задания нужно продолжить работу с CI приложения из лекции. То есть для начала выполнения этого домашнего задания необходимо проделать то, что показывалось в лекции. Все задание должно выполняться применительно к файлам в директории practice/8.ci-cd/app

Переделайте шаг деплоя в CI/CD, который демонстрировался на лекции таким образом, чтобы при каждом прогоне шага deploy в кластер применялись манифесты приложения. При этом версия докер образа в деплойменте при апплае должна подменяться на ту, что была собрана в шаге build.

Для этого самым очевидным способом было бы воспользоваться утилитой sed.

Измените образ в деплойменте приложения (файл kube/deployment.yaml) на плейсхолдер.

Вот это

    image: nginx:1.12 # это просто плэйсхолдер

На это

    image: __IMAGE__

Измените шаг деплоя в .gitlab-ci.yml, чтобы изменять IMAGE на реальное имя образа и тег

Это

    - kubectl set image deployment/$CI_PROJECT_NAME *=$CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG.$CI_PIPELINE_ID --namespace $CI_ENVIRONMENT_NAME

На это

    - sed -i "s,__IMAGE__,$CI_REGISTRY_IMAGE:$CI_COMMIT_REF_SLUG.$CI_PIPELINE_ID,g" kube/deployment.yaml
    - kubectl apply -f kube/ --namespace $CI_ENVIRONMENT_NAME

Вторую строчку шага деплоя (которая отслеживает статус деплоя) оставьте без изменений.

Попробуйте закоммитить свои изменения, запушить их в репозиторий (тот же, который вы создавали во время лекции на Gitlab.com) и посмотреть на выполнение CI в интерфейсе Gitlab.

Так как окружений у нас два (stage и prod), то помимо образа при апплае из CI нам также было бы хорошо подменять host в ingress.yaml. Попробуйте реализовать это по аналогии, подставляя в ингресс вместо плэйсхолдера значение переменной $CI_ENVIRONMENT_NAME

Так же попробуйте протестировать откат на предыдущую версию, при возникновении ошибки при деплое

Для этого можно изменить значение переменной DB_HOST в deployment.yaml на какое нибудь несуществующее. Тогда при старте приложения оно не сможет найти БД и будет постоянно рестрартовать. CI должен в течении progressDeadlineSeconds: 300 и по.сле этого запустить процедуру отката. При этом не должно возникать недоступности приложения, так как старая реплика должна продолжать работать, пока новая пытается стартануть.





----------------------------------------------------------------------------------------------------------------------------------------------------------------------



# Инструкция для лекции 8 - CI/CD

- [Подготовка](#Подготовка)
- [Настраиваем интеграцию GitLab и Kubernetes](#Настраиваем-интеграцию-GitLab-и-Kubernetes)
- [Запуск приложения](#Запуск-приложения)
- [Проверяем работу приложения](#Проверяем-работу-приложения)

## Подготовка

* Зарегистрируйте аккаунт [GitLab](https://gitlab.com/users/sign_up)
* добавьте в настройках своего аккаунта на Gitlab.com свой публичный SSH ключ

В правом верхнем углу выбираем **Preferences -> SSH keys** и добавляем SSH ключ

Чтобы вывести содержимае ключа выполните

```bash
cat ~/.ssh/id_rsa.pub
```

Сгенерировать SSH ключ можно командой

```bash
ssh-keygen
```

* Создайте новый проект с именем geekbrains. Если выберете другое имя проекта, в дальнейшем нужно будет также изменить имя Deployment.
* Скопируйте файлы практики в ваш репозиторий

```bash
cd app
git init --initial-branch=main
git remote add origin https://gitlab.com/<your_account>/geekbrains.git
git add .
git commit -m "Initial commit"
git push -u origin main
```

## Настраиваем интеграцию GitLab и Kubernetes

* Переходим в настройки проекта **Settings -> CI/CD -> Runners**. Отключаем Shared Runners. Мы будем настраивать Specific runners.
* Создаем нэймспэйс для раннера

```bash
kubectl create ns gitlab
```

* Меняем регистрационный токен
Для этого открываем gitlab-runner/gitlab-runner.yaml
Там ищем <CHANGE ME> и вставляем вместо него токен,
который мы взяли в настройках проекта на Gitlab (**Set up a specific runner manually -> Registration token**)

* Применяем манифесты для раннера

```bash
kubectl apply --namespace gitlab -f gitlab-runner/gitlab-runner.yaml
```

* Обновляем страницу на GitLab, runner должен появиться в списке Available specific runners 

* Создаем нэймспэйсы для приложения

```bash
kubectl create ns stage
kubectl create ns prod
```

* Создаем авторизационные объекты, чтобы раннер мог деплоить в наши нэймспэйсы

```bash
kubectl create sa deploy --namespace stage
kubectl create rolebinding deploy --serviceaccount stage:deploy --clusterrole edit --namespace stage
kubectl create sa deploy --namespace prod
kubectl create rolebinding deploy --serviceaccount prod:deploy --clusterrole edit --namespace prod
```

* Получаем токены для деплоя в нэймспэйсы

```bash
export NAMESPACE=stage; kubectl get secret $(kubectl get sa deploy --namespace $NAMESPACE -o jsonpath='{.secrets[0].name}') --namespace $NAMESPACE -o jsonpath='{.data.token}'
export NAMESPACE=prod; kubectl get secret $(kubectl get sa deploy --namespace $NAMESPACE -o jsonpath='{.secrets[0].name}') --namespace $NAMESPACE -o jsonpath='{.data.token}'
```

Из этих токенов нужно создать переменные в проекте в Gitlab (**Settings -> CI/CD -> Variables**) с именами
K8S_STAGE_CI_TOKEN и K8S_PROD_CI_TOKEN соответственно.

* Создаем секреты для авторизации Kubernetes в Gitlab registry. При создании используем Token, созданный в **Settings -> Repository -> Deploy Tokens**.
(read_registry, write_registry permissions)
```bash
kubectl create secret docker-registry gitlab-registry --docker-server=registry.gitlab.com --docker-username=<USERNAME> --docker-password=<PASSWORD> --docker-email=admin@admin.admin --namespace stage
kubectl create secret docker-registry gitlab-registry --docker-server=registry.gitlab.com --docker-username=<USERNAME> --docker-password=<PASSWORD> --docker-email=admin@admin.admin --namespace prod
```

* Патчим дефолтный сервис аккаунт для автоматического использование pull secret

```bash
kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "gitlab-registry"}]}' -n stage
kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "gitlab-registry"}]}' -n prod
```

## Запуск приложения

* Создаем манифесты для БД в stage и prod

```bash
kubectl apply --namespace stage -f app/kube/postgres/
kubectl apply --namespace prod -f app/kube/postgres/
```

* Меняем хост в ингрессе приложения и применяем манифесты
Для этого открываем app/kube/ingress.yaml
Там ищем плейсхолдер "CHANGE ME" и вставляем вместо него stage

Далее применяем на stage

```bash
kubectl apply --namespace stage -f app/kube
```

Повторяем для прода. Открываем тот же файл ingress и
вставляем вместо stage prod

Далее применяем на prod

```bash
kubectl apply --namespace prod -f app/kube
```

## Проверяем работу приложения

Поздравляю! Мы развернули приложение, теперь убедимся, что оно работает. Наше приложение - это REST-API. Можно выполнять к нему запросы через curl. В примерах указан недействительный ip адрес - 1.1.1.1, вам нужно заменить его на EXTERNAL-IP вашего сервиса ingres-controller (Load Balancer).


Записать информацию о клиенте в БД
```bash
curl 1.1.1.1/users -H "Host: stage" -X POST -d '{"name": "Vasiya", "age": 34, "city": "Vladivostok"}'
```

Получить список клиентов из БД
```bash
curl 1.1.1.1/users -H "Host: stage"
```


