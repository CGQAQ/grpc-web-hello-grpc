@echo off

kubectl.exe create namespace grpc-web-k8s  > nul 2> nul
kubectl apply -f grpc-web-k8s.yaml -n grpc-web-k8s