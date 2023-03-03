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
git remote add origin git@gitlab.com:artcloud/geekbrains
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


