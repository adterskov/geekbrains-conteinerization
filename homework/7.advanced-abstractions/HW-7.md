# Домашнее задание для к уроку 7 - Продвинутые абстракции Kubernetes

Создаём окружение

```
# kubectl create -f configmap.yaml
configmap/prometheus-cfg created

# kubectl create -f roles-api.yaml
serviceaccount/prometheus created
clusterrole.rbac.authorization.k8s.io/prometheus created
clusterrolebinding.rbac.authorization.k8s.io/prometheus created

# kubectl create -f statefulset.yaml
statefulset.apps/prometheus-sts created

# kubectl create -f ingress.yaml
ingress.networking.k8s.io/prometheus-ing created

# kubectl create -f service.yaml
service/prometheus-srv created
```

Проверяем

```
# kubectl get pod
NAME                       READY   STATUS    RESTARTS   AGE
prometheus-sts-0           1/1     Running   0          20s

# kubectl describe svc prometheus-srv
Name:              prometheus-srv
Namespace:         default
Labels:            app=prometheus
Annotations:       <none>
Selector:          app=prometheus
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.254.112.187
IPs:               10.254.112.187
Port:              <unset>  9090/TCP
TargetPort:        9090/TCP
Endpoints:         10.100.8.210:9090
Session Affinity:  None
Events:            <none>
root@disk:~/k8s/hw7# kubectl describe ingress prometheus-ing
Name:             prometheus-ing
Labels:           <none>
Namespace:        default
Address:          10.0.0.9
Ingress Class:    <none>
Default backend:  <default>
Rules:
  Host        Path  Backends
  ----        ----  --------
  *
              /   prometheus-srv:9090 (10.100.8.210:9090)
Annotations:  kubernetes.io/ingress.class: nginx
Events:
  Type    Reason  Age                   From                      Message
  ----    ------  ----                  ----                      -------
  Normal  Sync    4m6s (x2 over 4m15s)  nginx-ingress-controller  Scheduled for sync


# kubectl get svc -A
NAMESPACE        NAME                                 TYPE           CLUSTER-IP       EXTERNAL-IP      PORT(S)                      AGE
default          kubernetes                           ClusterIP      10.254.0.1       <none>           443/TCP                      16d
default          prometheus-srv                       ClusterIP      10.254.112.187   <none>           9090/TCP                     3m5s
ingress-nginx    ingress-nginx-controller             LoadBalancer   10.254.5.188     212.233.89.116   80:30080/TCP,443:30443/TCP   177m
ingress-nginx    ingress-nginx-controller-admission   ClusterIP      10.254.37.53     <none>           443/TCP                      177m
ingress-nginx    ingress-nginx-controller-metrics     ClusterIP      10.254.34.141    <none>           9913/TCP                     177m
ingress-nginx    ingress-nginx-default-backend        ClusterIP      10.254.194.117   <none>           80/TCP                       177m
kube-system      calico-node                          ClusterIP      None             <none>           9091/TCP                     16d
kube-system      calico-typha                         ClusterIP      10.254.135.66    <none>           5473/TCP                     16d
kube-system      csi-cinder-controller-service        ClusterIP      10.254.125.61    <none>           12345/TCP                    16d
kube-system      dashboard-metrics-scraper            ClusterIP      10.254.97.88     <none>           8000/TCP                     16d
kube-system      kube-dns                             ClusterIP      10.254.0.10      <none>           53/UDP,53/TCP,9153/TCP       16d
kube-system      kubernetes-dashboard                 ClusterIP      10.254.41.10     <none>           443/TCP                      16d
kube-system      metrics-server                       ClusterIP      10.254.242.10    <none>           443/TCP                      16d
opa-gatekeeper   gatekeeper-webhook-service           ClusterIP      10.254.69.192    <none>           443/TCP                      16d
```

Доступ по IP:
![prometheus-graph](https://github.com/Sergeomy/geekbrains-conteinerization/assets/86831924/f0ffac23-08cf-4397-a7ce-9f6ebcbfbb43)

Добавляем DaemonSet
```
# kubectl create -f daemonset.yaml
daemonset.apps/node-exporter created
```
![prometheus-targets](https://github.com/Sergeomy/geekbrains-conteinerization/assets/86831924/04ff9893-7b45-4e04-ad67-165e4061821d)

