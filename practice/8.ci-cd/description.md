### Развертывание
```bash
minikube start
```
#### 1. Удаляем и создаем нейсмспейс gitlab
```bash
k delete ns gitlab
k create ns gitlab
k config set-context --current --namespace=gitlab
```
#### 2. Создание gitlab-runner
```bash
kubectl apply --namespace gitlab -f gitlab-runner/gitlab-runner.yaml
```
#### 3. Создание нейсмспейс stage и prod
```bash
kubectl create ns stage
kubectl create ns prod
#Создаем авторизационные объекты, чтобы раннер мог деплоить в наши нэймспэйсы
kubectl create sa deploy --namespace stage
kubectl create rolebinding deploy --serviceaccount stage:deploy --clusterrole edit --namespace stage
kubectl create sa deploy --namespace prod
kubectl create rolebinding deploy --serviceaccount prod:deploy --clusterrole edit --namespace prod
#Получаем токены для деплоя в нэймспэйсы
export NAMESPACE=stage; kubectl get secret $(kubectl get sa deploy --namespace $NAMESPACE -o jsonpath='{.secrets[0].name}') --namespace $NAMESPACE -o jsonpath='{.data.token}'
export NAMESPACE=prod; kubectl get secret $(kubectl get sa deploy --namespace $NAMESPACE -o jsonpath='{.secrets[0].name}') --namespace $NAMESPACE -o jsonpath='{.data.token}'
```
#### 4. Создаем секреты для авторизации Kubernetes в Gitlab registry.
```bash
kubectl create secret docker-registry gitlab-registry --docker-server=registry.gitlab.com --docker-username=gitlab+deploy-token-1843862 --docker-password=mtiwTrnBi3DhoC8nTaW5 --docker-email=admin@admin.admin --namespace stage
kubectl create secret docker-registry gitlab-registry --docker-server=registry.gitlab.com --docker-username=gitlab+deploy-token-1843862 --docker-password=mtiwTrnBi3DhoC8nTaW5 --docker-email=admin@admin.admin --namespace prod
kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "gitlab-registry"}]}' -n stage
kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "gitlab-registry"}]}' -n prod
```
#### 5. Создаем манифесты для БД в stage и prod
```bash
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
```