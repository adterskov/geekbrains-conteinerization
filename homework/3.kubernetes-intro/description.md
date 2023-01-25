### Развертывание

#### 1. Удаляем и создаем нейсмспейс
```bash
kubectl delete ns kubedoom
kubectl create ns kubedoom
```
#### 2. Добавление манифеста и деплоймента
```bash
kubectl apply -f manifest.yaml -n kubedoom
kubectl apply -f doom.yaml -n kubedoom
```
#### 3. Информация о деплоя и описание деплоя
```bash
kubectl get deploy -n kubedoom
kubectl get rs -n kubedoom
kubectl describe deploy -n kubedoom
kubectl get po -n kubedoom
```
#### 4. Проброс портов 
```bash
kubectl port-forward deploy/kubedoom 5901:5900 -n kubedoom
```
#### 5. Запуск проложения Doom.
```bash
#Вводим пароль idbehold
vncviewer localhost:5901
```