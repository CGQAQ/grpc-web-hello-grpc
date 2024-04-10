# syntax=docker/dockerfile:1.7-labs

FROM namely/protoc-all AS PROTO_BUILDER

WORKDIR /proto
COPY /proto /proto
RUN ["protoc", "-I/opt/include", "-I.", "--js_out=import_style=commonjs:.","--grpc-web_out=import_style=typescript,mode=grpcwebtext:.", "hello.proto"]


FROM node:lts-alpine3.19 AS WEB_BUILDER

WORKDIR /app
COPY --exclude=web/node_modules/ web/ ./web/
COPY --from=PROTO_BUILDER /proto ./web/proto/

WORKDIR /app/web
RUN npm install
RUN npm run build

EXPOSE 3000

CMD ["npm", "run", "start"]


