### Развертывание

#### 1. Удаляем и создаем нейсмспейс
```bash
k delete ns pg
k create ns pg
```
#### 2. Создание секрета
```bash
k create secret generic postgres-secret --from-literal=PASS=testpassword -n pg
k get secret postgres-secret -n pg
```
#### 3. Создание pv и pvc
```bash
k apply -f pv.yaml -n pg
k apply -f pvc.yaml -n pg
k get pv -n pg
k get pvc -n pg
```
#### 4. Запуск деплоймента
```bash
k apply -f deployment.yaml -n pg
```
#### 5. Получаем IP пода.
```bash
k get pod -o wide -n pg
```
#### 6. Запускаем тестовый под
```bash
k run -t -i --rm --image postgres:10.13 test bash
# Введите пароль - testpassword
psql -h 172.17.0.7 -U testuser testdatabase
CREATE TABLE testtable (testcolumn VARCHAR (50) );
\dt
```