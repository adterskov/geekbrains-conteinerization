### Развертывание
```bash
minikube start
```
#### 1. Удаляем и создаем нейсмспейс
```bash
k delete ns l5
k create ns l5
k config set-context --current --namespace=l5
```
#### 2. Создание Postgres
```bash
k create secret generic postgres-secret --from-literal=PASS=testpassword
k apply -f postgres
```

#### 3. Создание Redmine
```bash
k create secret generic redmine-secret --from-literal=KEY=supersecretkey
k apply -f redmine
```