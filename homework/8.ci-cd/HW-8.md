# Домашнее задание для к уроку 8 - CI/CD

Создаём окружение Gitlab

```
# git init
Initialized empty Git repository in /root/k8s/hw8/app/.git/
# git remote add origin git@gitlab.com:Sergeomy/geekbrains.git
# git add .
# git commit -m "Initial commit"
[master (root-commit) 6e2c9ec] Initial commit
 17 files changed, 568 insertions(+)
 create mode 100644 .dockerignore
 create mode 100644 .gitlab-ci.yml
 create mode 100644 Dockerfile
 create mode 100644 app/app.go
 create mode 100644 config/config.go
 create mode 100644 go.mod
 create mode 100644 go.sum
 create mode 100644 handler/common.go
 create mode 100644 handler/users.go
 create mode 100644 kube/deployment.yaml
 create mode 100644 kube/ingress.yaml
 create mode 100644 kube/postgres/secret.yaml
 create mode 100644 kube/postgres/service.yaml
 create mode 100644 kube/postgres/statefulset.yaml
 create mode 100644 kube/service.yaml
 create mode 100644 main.go
 create mode 100644 model/model.go
 
# docker build -t registry.gitlab.com/gb_devops1/geekbrains .
```

Настраиваем интеграцию GitLab и Kubernetes

```
# kubectl create ns gitlab
namespace/gitlab created

# kubectl apply --namespace gitlab -f gitlab-runner/gitlab-runner.yaml
serviceaccount/gitlab-runner created
secret/gitlab-runner created
configmap/gitlab-runner created
role.rbac.authorization.k8s.io/gitlab-runner created
rolebinding.rbac.authorization.k8s.io/gitlab-runner created
deployment.apps/gitlab-runner created

# kubectl create ns stage
namespace/stage created
# kubectl create ns prod
namespace/prod created

# kubectl create sa deploy --namespace stage
serviceaccount/deploy created
# kubectl create rolebinding deploy --serviceaccount stage:deploy --clusterrole edit --namespace stage
rolebinding.rbac.authorization.k8s.io/deploy created
# kubectl create sa deploy --namespace prod
serviceaccount/deploy created
# kubectl create rolebinding deploy --serviceaccount prod:deploy --clusterrole edit --namespace prod
rolebinding.rbac.authorization.k8s.io/deploy created

# export NAMESPACE=stage; kubectl get secret $(kubectl get sa deploy --namespace $NAMESPACE -o jsonpath='{.secrets[0].name}') --namespace $NAMESPACE -o jsonpath='{.data.token}'
ZXlKaGJHY2lPaUpTVXpJMU5pSXNJbXRwWkNJNkluWjBZWFZJYjJGWFdtUklORzR6ZEMxSlpIcDJZV1p4UW1kWlpWZEVibU14UmpaM09IUkxlRlpvYWpnaWZRLmV5SnBjM01pT2lKcmRXSmxjbTVsZEdWekwzTmxjblpwWTJWaFkyTnZkVzUwSWl3aWEzVmlaWEp1WlhSbGN5NXBieTl6WlhKMmFXTmxZV05qYjNWdWRDOXVZVzFsYzNCaFkyVWlPaUp6ZEdGblpTSXNJbXQxWW1WeWJtVjBaWE11YVc4dmMyVnlkbWxqWldGalkyOTFiblF2YzJWamNtVjBMbTVoYldVaU9pSmtaWEJzYjNrdGRHOXJaVzR0YXpodFl6Z2lMQ0pyZFdKbGNtNWxkR1Z6TG1sdkwzTmxjblpwWTJWaFkyTnZkVzUwTDNObGNuWnBZMlV0WVdOamIzVnVkQzV1WVcxbElqb2laR1Z3Ykc5NUlpd2lhM1ZpWlhKdVpYUmxjeTVwYnk5elpYSjJhV05sWVdOamIzVnVkQzl6WlhKMmFXTmxMV0ZqWTI5MWJuUXVkV2xrSWpvaU5EVTBNR1l6Wm1JdE1qbGhZaTAwTnpreExXRmlZVEV0WkRFMU1ETTJNVGRsTWpKa0lpd2ljM1ZpSWpvaWMzbHpkR1Z0T25ObGNuWnBZMlZoWTJOdmRXNTBPbk4wWVdkbE9tUmxjR3h2ZVNKOS5sdWdKZ2lHMDh0eXhaVTU0SldLYXpWLS1waUpHMnc5VW5sbzJWOFM3SElGN3VaZ0JmbTdnbWxEQjhkTzVIeU13TFJWLUtVckREZk9MdUpFWnAyTWhsQXFhMGJyUXdKSUpaVk1GaWcxRDhxMVNjaHJLc2xxZ1NLaGZlSFFtNlJWMXZxT3BVWUJILWN4NXBnVDh6SWE1WFpYVXdQaHlHbTNQWU9xTTB3OG5ydVk0SEtBNHdQdGVEM0tMQkhMMmZLRDlvaDZSelQwUHVpek15LVBNRENNMWg2d2tSUnpNaFJVSXdRaktJTGRYOXVfUGs2UkYtZXZ1Uk5vOGpoZThNeUZxLXRrTTkzNXVnaXJ1WlJtRnhZdXRUV1I1dEdJbk8zblhiLVA1QkVYU2lZOS14S2ZxUWZpYUdjcnktNHhwTVhTc05LTjVYNXEtRW9wZkRKU3JleEl1eXc=

# export NAMESPACE=prod; kubectl get secret $(kubectl get sa deploy --namespace $NAMESPACE -o jsonpath='{.secrets[0].name}') --namespace $NAMESPACE -o jsonpath='{.data.token}'
ZXlKaGJHY2lPaUpTVXpJMU5pSXNJbXRwWkNJNkluWjBZWFZJYjJGWFdtUklORzR6ZEMxSlpIcDJZV1p4UW1kWlpWZEVibU14UmpaM09IUkxlRlpvYWpnaWZRLmV5SnBjM01pT2lKcmRXSmxjbTVsZEdWekwzTmxjblpwWTJWaFkyTnZkVzUwSWl3aWEzVmlaWEp1WlhSbGN5NXBieTl6WlhKMmFXTmxZV05qYjNWdWRDOXVZVzFsYzNCaFkyVWlPaUp3Y205a0lpd2lhM1ZpWlhKdVpYUmxjeTVwYnk5elpYSjJhV05sWVdOamIzVnVkQzl6WldOeVpYUXVibUZ0WlNJNkltUmxjR3h2ZVMxMGIydGxiaTEwTldaMGNDSXNJbXQxWW1WeWJtVjBaWE11YVc4dmMyVnlkbWxqWldGalkyOTFiblF2YzJWeWRtbGpaUzFoWTJOdmRXNTBMbTVoYldVaU9pSmtaWEJzYjNraUxDSnJkV0psY201bGRHVnpMbWx2TDNObGNuWnBZMlZoWTJOdmRXNTBMM05sY25acFkyVXRZV05qYjNWdWRDNTFhV1FpT2lKbVpUSTRNVGczTmkweVpqSTVMVFJoTlRFdFlqazNNQzB5TmpVNVlqTmxaREExTkRraUxDSnpkV0lpT2lKemVYTjBaVzA2YzJWeWRtbGpaV0ZqWTI5MWJuUTZjSEp2WkRwa1pYQnNiM2tpZlEuY1czT1Z2VnkyaWpCTkpYLWxBN1FqWjQzY2dIX1V5Y2ttMWVsb0RHOTFlTzBoandnaHBGa0lvVXU0SGozSTI1ckw5dXg1WlpucWZLVU1YVDJzUmdkdmhRVHlaLXNMUXJCZ0ljRnRJUXhiU29jbnZEUWUweWxCRXFJcm1rX1MybDd5dmxmR3RKTTI0aHJpRGhMUkJyRVRiNWoxazVWZEF2M0E3QjlwNldRR1pNUlBPR3RRQ1dJdkpzRUpVNDdrZlJfTWprZXdnbXhYME1wa2JQWHNSQ18yYUFXck5iSjlmS3FMdWVJMU44RTJoOWN3OV9nb05UUlhXSDZyc0NnNnU2anhJM3lobHZkbXF5VzRMRGNkS1llUWZ4V3JTLUlhRlpLM1VzLWEzSGxrbEhDQy1jYzlwX19JeGZMVjNBZEhMa0p2dWFUal9Ibnl5QmhncTV0UG5rd09R

# kubectl create secret docker-registry gitlab-registry --docker-server=registry.gitlab.com --docker-username=smgb --docker-password=rSE_yiHmbcf9duQDev-j --docker-email=admin@admin.admin --namespace stage
secret/gitlab-registry created

# kubectl create secret docker-registry gitlab-registry --docker-server=registry.gitlab.com --docker-username=smgb --docker-password=-rSE_yiHmbcf9duQDev-j --docker-email=admin@admin.admin --namespace prod
secret/gitlab-registry created


# kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "gitlab-registry"}]}' -n stage
serviceaccount/default patched
# kubectl patch serviceaccount default -p '{"imagePullSecrets": [{"name": "gitlab-registry"}]}' -n prod
serviceaccount/default patched
```

Запуск приложения

```
# kubectl apply --namespace stage -f app/kube/postgres/
secret/app created
service/database created
statefulset.apps/database created

# kubectl apply --namespace prod -f app/kube/postgres/
secret/app created
service/database created
statefulset.apps/database created

# kubectl apply --namespace stage -f app/kube
deployment.apps/geekbrains created
ingress.networking.k8s.io/geekbrains created
service/geekbrains created

# kubectl apply --namespace prod -f app/kube
deployment.apps/geekbrains created
ingress.networking.k8s.io/geekbrains created
service/geekbrains created

# kubectl get pod -n stage
NAME                          READY   STATUS    RESTARTS   AGE
database-0                    1/1     Running   7          5d3h
geekbrains-5b7fd8d664-fbpnp   1/1     Running   0          17m
geekbrains-5b7fd8d664-zhtvl   1/1     Running   0          17m

# kubectl get pod -n prod
NAME                          READY   STATUS    RESTARTS   AGE
database-0                    1/1     Running   7          5d3h
geekbrains-5b7fd8d664-hx24f   1/1     Running   0          16m
geekbrains-5b7fd8d664-r9qbz   1/1     Running   0          16m


# kubectl get services -A                                                                    NAMESPACE        NAME                                 TYPE           CLUSTER-IP       EXTERNAL-IP     PORT(S)                      AGE
default          kubernetes                           ClusterIP      10.254.0.1       <none>          443/TCP                      5d8h
ingress-nginx    ingress-nginx-controller             LoadBalancer   10.254.245.246   212.233.89.49   80:30080/TCP,443:30443/TCP   3d8h
ingress-nginx    ingress-nginx-controller-admission   ClusterIP      10.254.16.109    <none>          443/TCP                      3d8h
ingress-nginx    ingress-nginx-controller-metrics     ClusterIP      10.254.230.215   <none>          9913/TCP                     3d8h
ingress-nginx    ingress-nginx-default-backend        ClusterIP      10.254.79.186    <none>          80/TCP                       3d8h
kube-system      calico-node                          ClusterIP      None             <none>          9091/TCP                     5d8h
kube-system      calico-typha                         ClusterIP      10.254.211.55    <none>          5473/TCP                     5d8h
kube-system      csi-cinder-controller-service        ClusterIP      10.254.142.57    <none>          12345/TCP                    5d8h
kube-system      dashboard-metrics-scraper            ClusterIP      10.254.30.255    <none>          8000/TCP                     5d8h
kube-system      kube-dns                             ClusterIP      10.254.0.10      <none>          53/UDP,53/TCP,9153/TCP       5d8h
kube-system      kubernetes-dashboard                 ClusterIP      10.254.87.10     <none>          443/TCP                      5d8h
kube-system      metrics-server                       ClusterIP      10.254.123.25    <none>          443/TCP                      5d8h
opa-gatekeeper   gatekeeper-webhook-service           ClusterIP      10.254.14.67     <none>          443/TCP                      5d8h
prod             database                             ClusterIP      10.254.239.34    <none>          5432/TCP                     5d3h
prod             geekbrains                           ClusterIP      10.254.124.130   <none>          8000/TCP                     5d3h
stage            database                             ClusterIP      10.254.73.151    <none>          5432/TCP                     5d3h
stage            geekbrains                           ClusterIP      10.254.214.88    <none>          8000/TCP                     5d3h

```

Проверяем

```
# curl 212.233.89.49/users -H "Host: stage" -X POST -d '{"name": "Vasiya", "age": 34, "city": "Vladivostok"}'
{"ID":1,"CreatedAt":"2023-05-29T14:05:40.741034631Z","UpdatedAt":"2023-05-29T14:05:40.741034631Z","DeletedAt":null,"name":"Vasiya","city":"Vladivostok","age":34,"status":false}

# curl 212.233.89.49/users -H "Host: stage" -X POST -d '{"name": "Petya", "age": 43, "city": "Samara"}'
{"ID":2,"CreatedAt":"2023-05-29T14:37:54.473964734Z","UpdatedAt":"2023-05-29T14:37:54.473964734Z","DeletedAt":null,"name":"Petya","city":"Samara","age":43,"status":false}

# curl 212.233.89.49/users -H "Host: stage"
[{"ID":1,"CreatedAt":"2023-05-29T14:05:40.741035Z","UpdatedAt":"2023-05-29T14:05:40.741035Z","DeletedAt":null,"name":"Vasiya","city":"Vladivostok","age":34,"status":false},{"ID":2,"CreatedAt":"2023-05-29T14:37:54.473965Z","UpdatedAt":"2023-05-29T14:37:54.473965Z","DeletedAt":null,"name":"Petya","city":"Samara","age":43,"status":false}]
```

Проверка отката при неудачном старте

```
# kubectl get pod -n stage
NAME                          READY   STATUS    RESTARTS   AGE
database-0                    1/1     Running   7          5d3h
geekbrains-5b7fd8d664-fbpnp   1/1     Running   0          25m
geekbrains-5b7fd8d664-zhtvl   1/1     Running   0          25m

# kubectl get pod -n stage
NAME                          READY   STATUS              RESTARTS   AGE
database-0                    1/1     Running             7          5d3h
geekbrains-5b7fd8d664-fbpnp   1/1     Running             0          25m
geekbrains-5b7fd8d664-zhtvl   1/1     Running             0          25m
geekbrains-f4dcc97f8-4kh76    0/1     ContainerCreating   0          3s
root@disk:~/k8s/hw8# kubectl get pod -n stage
NAME                          READY   STATUS    RESTARTS   AGE
database-0                    1/1     Running   7          5d3h
geekbrains-5b7fd8d664-fbpnp   1/1     Running   0          25m
geekbrains-5b7fd8d664-zhtvl   1/1     Running   0          25m
geekbrains-f4dcc97f8-4kh76    0/1     Error     0          7s

# kubectl get pod -n stage
NAME                          READY   STATUS             RESTARTS     AGE
database-0                    1/1     Running            7            5d3h
geekbrains-5b7fd8d664-fbpnp   1/1     Running            0            25m
geekbrains-5b7fd8d664-zhtvl   1/1     Running            0            25m
geekbrains-f4dcc97f8-4kh76    0/1     CrashLoopBackOff   1 (3s ago)   9s

# kubectl get pod -n stage
NAME                          READY   STATUS    RESTARTS       AGE
database-0                    1/1     Running   7              5d4h
geekbrains-5b7fd8d664-fbpnp   1/1     Running   0              28m
geekbrains-5b7fd8d664-zhtvl   1/1     Running   0              28m
geekbrains-f4dcc97f8-4kh76    0/1     Error     5 (102s ago)   3m26s

# kubectl get pod -n stage
NAME                          READY   STATUS    RESTARTS   AGE
database-0                    1/1     Running   7          5d4h
geekbrains-5b7fd8d664-fbpnp   1/1     Running   0          31m
geekbrains-5b7fd8d664-zhtvl   1/1     Running   0          31m
```

Результаты запуска Pipeline: https://gitlab.com/gb_devops1/geekbrains/-/pipelines
