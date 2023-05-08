# Домашняя работа к уроку 4: Хранение данных и ресурсы

```
# kubectl create ns hw4
namespace/hw4 created
```

```
# kubectl create secret generic --from-literal=PASSWORD=PostPass1@3 psg-secret -n hw4
secret/psg-secret created
```

```
# kubectl get secret -n hw4 psg-secret -o yaml
apiVersion: v1
data:
  PASSWORD: UG9zdFBhc3MxQDM=
kind: Secret
metadata:
  creationTimestamp: "2023-05-08T19:38:14Z"
  name: psg-secret
  namespace: hw4
  resourceVersion: "20607"
  selfLink: /api/v1/namespaces/hw4/secrets/psg-secret
  uid: 275566b4-26d6-431c-aa8b-9974486eec1e
type: Opaque
```

```
# kubectl apply -f pvc.yaml -n hw4
persistentvolumeclaim/postgres-pvc created
```

```
# kubectl apply -f deploy.yaml -n hw4
deployment.apps/postgres created
```

```
# kubectl exec postgres-54dbf8d94b-lzqd5 -n hw4 env
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/postgresql/10/bin
TERM=xterm
HOSTNAME=postgres-54dbf8d94b-lzqd5
PGDATA=/var/lib/postgresql/data/pgdata
POSTGRES_PASSWORD=PostPass1@3
POSTGRES_USER=testuser
POSTGRES_DB=testdatabase
KUBERNETES_PORT_443_TCP_PORT=443
KUBERNETES_PORT_443_TCP_ADDR=10.254.0.1
KUBERNETES_SERVICE_HOST=10.254.0.1
KUBERNETES_SERVICE_PORT=443
KUBERNETES_SERVICE_PORT_HTTPS=443
KUBERNETES_PORT=tcp://10.254.0.1:443
KUBERNETES_PORT_443_TCP=tcp://10.254.0.1:443
KUBERNETES_PORT_443_TCP_PROTO=tcp
GOSU_VERSION=1.12
LANG=en_US.utf8
PG_MAJOR=10
PG_VERSION=10.13-1.pgdg90+1
HOME=/root
```

# Проверка

```
# kubectl get pod -o wide -n hw4
NAME                        READY   STATUS    RESTARTS   AGE     IP               NODE                                     NOMINATED NODE   READINESS GATES
postgres-54dbf8d94b-lzqd5   1/1     Running   0          3m25s   10.100.151.193   kubernetes-cluster-ms-01-group-ms-01-2   <none>           <none>
```

```
# kubectl run -t -i --rm --image postgres:10.13 test bash
If you don't see a command prompt, try pressing enter.
root@test:/# psql -h 10.100.151.193 -U testuser testdatabase
Password for user testuser:
psql (10.13 (Debian 10.13-1.pgdg90+1))
Type "help" for help.

testdatabase=# CREATE TABLE testtable (testcolumn VARCHAR (50) );
CREATE TABLE
testdatabase=# \dt
           List of relations
 Schema |   Name    | Type  |  Owner
--------+-----------+-------+----------
 public | testtable | table | testuser
(1 row)

testdatabase=#
testdatabase=# \q
root@test:/# exit
exit
Session ended, resume using 'kubectl attach test -c test -i -t' command when the pod is running
pod "test" deleted
```

```
# kubectl get pod -n hw4
NAME                        READY   STATUS    RESTARTS   AGE
postgres-54dbf8d94b-lzqd5   1/1     Running   0          9m57s

# kubectl delete pod postgres-54dbf8d94b-lzqd5 -n hw4
pod "postgres-54dbf8d94b-lzqd5" deleted

# kubectl get pod -n hw4
NAME                        READY   STATUS              RESTARTS   AGE
postgres-54dbf8d94b-ptq9n   0/1     ContainerCreating   0          4s
```
```
# kubectl get pod -o wide -n hw4
NAME                        READY   STATUS    RESTARTS   AGE   IP             NODE                                     NOMINATED NODE   READINESS GATES
postgres-54dbf8d94b-ptq9n   1/1     Running   0          88s   10.100.8.193   kubernetes-cluster-ms-01-group-ms-01-1   <none>           <none>
root@disk:~/k8s/hw4# kubectl run -t -i --rm --image postgres:10.13 test bash
If you don't see a command prompt, try pressing enter.
root@test:/# psql -h 10.100.8.193 -U testuser testdatabase
Password for user testuser:
psql (10.13 (Debian 10.13-1.pgdg90+1))
Type "help" for help.

testdatabase=# \dt
           List of relations
 Schema |   Name    | Type  |  Owner
--------+-----------+-------+----------
 public | testtable | table | testuser
(1 row)

testdatabase=# \q
root@test:/# exit
exit
Session ended, resume using 'kubectl attach test -c test -i -t' command when the pod is running
pod "test" deleted
```