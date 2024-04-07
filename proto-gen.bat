@echo off

PATH=%PATH%;.;web/node_modules/.bin

protoc --go_out=. --go_opt=paths=source_relative ^
    --go-grpc_out=. --go-grpc_opt=paths=source_relative ^
    proto/hello.proto

if exist web\proto rmdir /s /q web\proto
mkdir web\proto

protoc -I=proto proto/hello.proto ^
    --js_out=import_style=commonjs:web/proto ^
    --grpc-web_out=import_style=typescript,mode=grpcwebtext:web/proto