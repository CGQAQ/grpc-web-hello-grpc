#!/usr/bin/env sh

kubectl create namespace grpc-web-k8s 2>/dev/null
kubectl apply -f grpc-web-k8s.yaml -n grpc-web-k8s