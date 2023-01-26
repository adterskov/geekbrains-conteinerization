#!/bin/bash

kubectl create ns lesson5
kubectl config set-context --current --namespace=lesson5

# Create DB

kubectl create secret generic postgres-secret --from-literal=PASS=testpassword
kubectl apply -f pg-pv.yaml
kubectl apply -f pg-pvc.yaml
kubectl apply -f pg-deployment.yaml
kubectl apply -f pg-service.yaml

# Create RedMine

kubectl create secret generic redmine-secret --from-literal=KEY=supersecretkey
kubectl apply -f rm-deployment.yaml
kubectl apply -f rm-service.yaml
kubectl apply -f rm-ingress.yaml