# Домашнее задание для к уроку 7 - Продвинутые абстракции Kubernetes

> ! Задание нужно выполнять в нэймспэйсе default

Разверните в кластере сервер системy мониторинга Prometheus.

* Создайте в кластере ConfigMap со следующим содержимым:

```yaml
prometheus.yml: |
  global:
    scrape_interval: 30s
  
  scrape_configs:
    - job_name: 'prometheus'
      static_configs:
      - targets: ['localhost:9090']

    - job_name: 'kubernetes-nodes'
      kubernetes_sd_configs:
      - role: node
      relabel_configs:
      - source_labels: [__address__]
        regex: (.+):(.+)
        target_label: __address__
        replacement: ${1}:9101
```

Создайте объекты для авторизации Prometheus сервера в Kubernetes-API.

```yaml
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: prometheus
  namespace: default
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: prometheus
rules:
- apiGroups: [""]
  resources:
  - nodes
  verbs: ["get", "list", "watch"]
---  
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: prometheus
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: prometheus
subjects:
- kind: ServiceAccount
  name: prometheus
  namespace: default
```

* Создайте StatefulSet для Prometheus сервера из образа prom/prometheus:v2.19.2 с одной репликой

В нем должнен быть описан порт 9090 TCP
volumeClaimTemplate - ReadWriteOnce, 5Gi, подключенный по пути /prometheus
Подключение конфигмапа с настройками выше по пути /etc/prometheus

Так же в этом стейтфулсете нужно объявить initContainer для изменения права на 777 для каталога /prometheus.
См пример из лекции 4: practice/4.resources-and-persistence/persistence/deployment.yaml

> Не забудьте указать обязательное поле serviceName

Так же укажите поле serviceAccount: prometheus на одном уровне с containers, initContainers, volumes
См пример с rabbitmq из материалов лекции.

* Создайте service и ingress для этого стейтфулсета, так чтобы запросы с любым доменом на белый IP
вашего сервиса nginx-ingress-controller (тот что в нэймспэйсе ingress-nginx с типом LoadBalancer)
шли на приложение

* Проверьте что при обращении из браузера на белый IP вы видите открывшееся
приложение Prometheus

* В этом же неймспэйсе создайте DaemonSet node-exporter как в примере к лекции:
practice/7.advanced-abstractions/daemonset.yaml

* Откройте в браузере интерфейс Prometheus.
Попробуйте открыть Status -> Targets
Тут вы должны увидеть все ноды своего кластера, которые Prometheus смог определить и собирает с ним метрики.

Так же можете попробовать на вкладке Graph выполнить запрос node_load1 - это минутный Load Average для каждой из нод в кластере.
