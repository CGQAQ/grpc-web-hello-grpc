# GRPC server in Golang and client in react/web, Unary RPC and Server streaming RPC demos


### On Windows:
#### prerequisites:
- Golang 1.22 (for grpc backend)
- protoc      (for compile .proto files)
- nodejs      (for frontend deps)
- yarn        (for frontend deps)
- docker      (for envoy)

#### HOW TO (Windows)
- double click `launch-grpc-server.bat` to launch grpc server
- double click `launch-envoy.bat` to launch envoy proxy to translate `grpc-webtext` to `grpc`
- double click `launch-grpc-web.bat` to launch next dev server
- open `http://localhost:3000` in browser

### HOW TO (Any system that have k8s installed)
- double click k8s-apply.bat on Windows
- run `k8s-apply.sh` on Unix like system
