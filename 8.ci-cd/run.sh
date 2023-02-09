#!/bin/bash

echo "Прежде чем продолжить необходимо выполнить шаг ## Подготовка"
echo "Данный шаг выполнен yes/no?"
read step_1
if [ $step_1 = 'yes' ]
then
    echo "Создаем нэймспэйс для раннера.."
    kubectl create ns gitlab
    echo "Укажите регистрационный токен:"
    read token
    sed -i "s/Enter your registration token here/$token/g" gitlab-runner/gitlab-runner.yaml
    echo "Применяем манифесты для раннера.."
    kubectl apply --namespace gitlab -f gitlab-runner/gitlab-runner.yaml
    echo "Обновляем страницу на GitLab, runner должен появиться в списке Available specific runners"
else
    echo "Выход..."
fi

echo "Данный шаг выполнен yes/no?"
read step_2
if [ $step_2 = 'yes' ]
then
    echo "Создаем нэймспэйсы для приложения.."
    kubectl create ns stage
    kubectl create ns prod
    echo "Создаем авторизационные объекты, чтобы раннер мог деплоить в наши нэймспэйсы.."
    kubectl create sa deploy --namespace stage
    kubectl create rolebinding deploy --serviceaccount stage:deploy --clusterrole edit --namespace stage
    kubectl create sa deploy --namespace prod
    kubectl create rolebinding deploy --serviceaccount prod:deploy --clusterrole edit --namespace prod
    echo "Получаем токены для деплоя в нэймспэйсы.."
    echo "stage:"
    export NAMESPACE=stage; kubectl get secret $(kubectl get sa deploy --namespace $NAMESPACE -o jsonpath='{.secrets[0].name}') --namespace $NAMESPACE -o jsonpath='{.data.token}'
    echo "prod:"
    export NAMESPACE=prod; kubectl get secret $(kubectl get sa deploy --namespace $NAMESPACE -o jsonpath='{.secrets[0].name}') --namespace $NAMESPACE -o jsonpath='{.data.token}'
    echo "Из этих токенов нужно создать переменные в проекте в Gitlab (**Settings -> CI/CD -> Variables**) с именами K8S_STAGE_CI_TOKEN и K8S_PROD_CI_TOKEN соответственно."

else
    echo "Выход..."
fi

echo "Данный шаг выполнен yes/no?"
read step_3
if [ $step_3 = 'yes' ]
then
    echo "Создаем секреты для авторизации Kubernetes в Gitlab registry. При создании используем Token, созданный в **Settings -> Repository -> Deploy Tokens**. (read_registry, write_registry permissions)"
    echo "Deploy token username:"
    read username
    echo "Deploy token password:"
    read password
    kubectl create secret docker-registry gitlab-registry --docker-server=registry.gitlab.com --docker-username=$username --docker-password=$password --docker-email=admin@admin.admin --namespace stage
    kubectl create secret docker-registry gitlab-registry --docker-server=registry.gitlab.com --docker-username=$username --docker-password=$password --docker-email=admin@admin.admin --namespace prod
    echo "Патчим дефолтный сервис аккаунт для автоматического использование pull secret.."
    kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "gitlab-registry"}]}' -n stage
    kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "gitlab-registry"}]}' -n prod
else
    echo "Выход..."
fi

echo "Данный шаг выполнен yes/no?"
read step_4
if [ $step_4 = 'yes' ]
then
    echo "Создаем манифесты для БД в stage и prod.."
    sed -i "s/postgresql-volume/pg-stage-volume/g" app/kube/postgres/pv.yaml
    kubectl apply --namespace stage -f app/kube/postgres/
    sed -i "s/pg-stage-volume/pg-prod-volume/g" app/kube/postgres/pv.yaml
    kubectl apply --namespace prod -f app/kube/postgres/
    sed -i "s/pg-prod-volume/postgresql-volume/g" app/kube/postgres/pv.yaml
    echo "Меняем хост в ингрессе приложения и применяем манифесты.."
    echo "для stage.."
    sed -i "s/<CHANGE ME>/stage/g" app/kube/ingress.yaml
    kubectl apply --namespace stage -f app/kube
    echo "для prod.."
    sed -i "s/stage/prod/g" app/kube/ingress.yaml
    kubectl apply --namespace prod -f app/kube
    sed -i "s/prod/<CHANGE ME>/g" app/kube/ingress.yaml
else
    echo "Выход..."
fi
