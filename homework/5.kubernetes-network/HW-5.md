# Домашняя работа к уроку 5: Сетевые абстракции Kubernetes

```
# kubectl create ns hw5
namespace/hw5 created
```

```
# kubectl create secret generic --from-literal=PASSWORD=PostPass1@3 psg-secret -n hw5
secret/psg-secret created
```

```
# kubectl create secret generic --from-literal=KEY=RdmPass1@3 rdm-secret -n hw5
secret/rdm-secret created
```

```
# kubectl get secret -n hw5 pgs-secret -o yaml
apiVersion: v1
data:
  PASSWORD: UG9zdFBhc3MxQDM=
kind: Secret
metadata:
  name: pgs-secret
  namespace: hw5
type: Opaque
```

```
# kubectl get secret -n hw5 rdm-secret -o yaml
apiVersion: v1
data:
  KEY: UmRtUGFzczFAMw==
kind: Secret
metadata:
  name: rdm-secret
  namespace: hw5
type: Opaque
```

```
# kubectl apply -f pvc.yaml -n hw5
persistentvolumeclaim/postgres-pvc created
```

```
# kubectl apply -f deploy-pgs.yaml -n hw5
deployment.apps/postgres created
```

```
# kubectl create -f service-pgs.yaml
service/database created
```

```
# kubectl create -f service-rdm.yaml
service/redmine created
```

```
# kubectl get service -n hw5
NAME       TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
database   ClusterIP   10.254.160.212   <none>        5432/TCP   13h
redmine    ClusterIP   10.254.169.88    <none>        3000/TCP   13h
```

```
# kubectl apply -f ingress.yaml -n hw5
ingress.networking.k8s.io/ingress created
```

```
# kubectl describe ingress
Name:             ingress-hw5
Labels:           <none>
Namespace:        default
Address:          10.0.0.9
Ingress Class:    nginx
Default backend:  <default>
Rules:
  Host        Path  Backends
  ----        ----  --------
  *
              /   redmine:3000 (10.100.8.203:3000)
Annotations:  kubernetes.io: nginx
Events:       <none>
```

# Проверка

```
# kubectl get service -A
NAMESPACE        NAME                                 TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)                      AGE
hw5              database                             ClusterIP      10.254.160.212   <none>           5432/TCP                     17h
hw5              net-tool                             ClusterIP      10.254.113.208   <none>           8080/TCP                     122m
hw5              redmine                              ClusterIP      10.254.169.88    <none>           3000/TCP                     17h
ingress-nginx    ingress-nginx-controller             LoadBalancer   10.254.114.80    109.120.191.10   80:30080/TCP,443:30443/TCP   87m
ingress-nginx    ingress-nginx-controller-admission   ClusterIP      10.254.34.98     <none>           443/TCP                      87m
ingress-nginx    ingress-nginx-controller-metrics     ClusterIP      10.254.138.252   <none>           9913/TCP                     87m
ingress-nginx    ingress-nginx-default-backend        ClusterIP      10.254.235.243   <none>           80/TCP   
```

```
# curl 109.120.191.10
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<title>Redmine</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="Redmine" />
<meta name="keywords" content="issue,bug,tracker" />
<meta name="csrf-param" content="authenticity_token" />
<meta name="csrf-token" content="qZjPtSA8cmJzMQVQ6/ddOpHQU7NRjBiB+6pep6u1aAirFZIhF0V/LMbnZihI+gObRgPUC9QeBCB6UeNpsvJ24Q==" />
<link rel='shortcut icon' href='/favicon.ico?1586192449' />
<link rel="stylesheet" media="all" href="/stylesheets/jquery/jquery-ui-1.11.0.css?1586192448" />
<link rel="stylesheet" media="all" href="/stylesheets/tribute-3.7.3.css?1586192449" />
<link rel="stylesheet" media="all" href="/stylesheets/application.css?1586192449" />
<link rel="stylesheet" media="all" href="/stylesheets/responsive.css?1586192449" />
...
```

![redmine](https://github.com/Sergeomy/geekbrains-conteinerization/assets/86831924/cffd9cdd-6e37-48f0-b0b6-92466ab7de6b)
