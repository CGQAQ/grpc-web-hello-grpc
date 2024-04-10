@echo off

docker build -t cgqaq/grpc-web-hello-grpc-backend -f backend.Dockerfile .
docker push cgqaq/grpc-web-hello-grpc-backend

docker build -t cgqaq/grpc-web-hello-grpc-web -f frontend.Dockerfile .
docker push cgqaq/grpc-web-hello-grpc-web

docker build -t cgqaq/grpc-web-hello-grpc-envoy -f envoy.Dockerfile .
docker push cgqaq/grpc-web-hello-grpc-envoy