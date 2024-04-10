FROM namely/protoc-all AS PROTO_BUILDER

WORKDIR /proto
COPY /proto /proto
RUN ["protoc", "-I/opt/include", "-I.", "--go_out=.", "--go_opt=paths=source_relative", "--go-grpc_out=.", "--go-grpc_opt=paths=source_relative", "hello.proto"]

FROM golang:1.22.2-alpine

WORKDIR /app
COPY /cmd ./cmd
COPY go.mod .
COPY go.sum .
COPY --from=PROTO_BUILDER /proto /app/proto/

EXPOSE 6668

CMD go run cmd/server/server.go