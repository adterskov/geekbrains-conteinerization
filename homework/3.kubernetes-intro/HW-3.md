# Домашняя работа к уроку 3: Введение в Kubernetes.

```
kubectl get node</br>
NAME                                     STATUS   ROLES    AGE   VERSION
kubernetes-cluster-ms-01-group-ms-01-0   Ready    <none>   15m   v1.22.9
kubernetes-cluster-ms-01-group-ms-01-1   Ready    <none>   15m   v1.22.9
kubernetes-cluster-ms-01-group-ms-01-2   Ready    <none>   15m   v1.22.9
kubernetes-cluster-ms-01-master-0        Ready    master   16m   v1.22.9
```

```
kubectl create -f dep_doom.yaml -n kubedoom
deployment.apps/ms-doom created
```

```
kubectl create -f cladm.yaml -n kubedoom
serviceaccount/kubedoom created
clusterrolebinding.rbac.authorization.k8s.io/kubedoom created
```

```
xtightvncviewer localhost::5900
Connected to RFB server, using protocol version 3.8
Performing standard VNC authentication
Password:
Authentication successful
Desktop name "kubernetes-cluster-ms-01-group-ms-01-0.novalocal:99"
VNC server default format:
  32 bits per pixel.
  Least significant byte first in each pixel.
  True colour: max red 255 green 255 blue 255, shift red 16 green 8 blue 0
Using default colormap which is TrueColor.  Pixel format:
  32 bits per pixel.
  Least significant byte first in each pixel.
  True colour: max red 255 green 255 blue 255, shift red 16 green 8 blue 0
Same machine: preferring raw encoding
```