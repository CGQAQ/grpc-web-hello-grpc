@echo off

docker build -t envoy .
docker run -p 60669:60669 envoy