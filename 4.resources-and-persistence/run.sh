#!/bin/bash

kubectl create ns lesson4

kubectl create secret generic postgres-secret --from-literal=PASS=testpassword -n lesson4
kubectl get secret postgres-secret -n lesson4

kubectl apply -f pv.yaml -n lesson4
kubectl apply -f pvc.yaml -n lesson4
kubectl get pv -n lesson4
kubectl get pvc -n lesson4

kubectl apply -f deployment.yaml -n lesson4

sleep 5

kubectl get pod -o wide -n lesson4
