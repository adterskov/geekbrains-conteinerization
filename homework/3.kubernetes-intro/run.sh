#!/bin/bash

kubectl create ns kubedoom

kubectl apply -f deployment.yaml -n kubedoom
kubectl apply -f rbac.yaml -n kubedoom

sleep 10

echo "pass: idbehold"

kubectl port-forward $(kubectl get pod -n kubedoom | grep 'kubedoom' | awk '{print $1}') 5900:5900 -n kubedoom 