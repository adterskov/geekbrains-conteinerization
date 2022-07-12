**Persistent Storage**

Руководства по работе с хранилищами в VK Cloud
https://mcs.mail.ru/docs/base/k8s/k8s-pvc

Посмотреть доступные Storage Class
```
kubectl get storageclasses.storage.k8s.io
```

<br>Вы можете менять политику persistentVolumeReclaimPolicy тем самым указывая нужно ли сохранять данные после удаления pods или нет
<br>https://kubernetes.io/docs/concepts/storage/persistent-volumes/#reclaim-policy
