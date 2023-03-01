### Развертывание
```bash
minikube start
```
#### 1. Удаляем и создаем нейсмспейс
```bash
k delete ns l7
k create ns l7
k config set-context --current --namespace=l7
```
#### 2. Создание Postgres
```bash
k apply -f prometheus
```

#### 3. Создание Daemonset
```bash
k create -f daemonset.yaml
```