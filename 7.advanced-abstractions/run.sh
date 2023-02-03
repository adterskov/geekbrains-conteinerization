#!/bin/bash

kubectl create ns lesson7
kubectl config set-context --current --namespace=lesson7

# Start Prometheus

kubectl apply -f prom_pv.yaml
kubectl apply -f prom_configmap.yaml
kubectl apply -f prom_serviceaccount.yaml
kubectl apply -f prom_clusterrole.yaml
kubectl apply -f prom_clusterrolebinding.yaml
kubectl apply -f prom_statefulset.yaml
kubectl apply -f prom_service.yaml
kubectl apply -f prom_ingress.yaml

# Start Node-exporters
kubectl create -f prom_daemonset.yaml
