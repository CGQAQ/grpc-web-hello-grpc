package main

import (
	"context"
	"fmt"
	pb "github.com/cgqaq/grpc-web-hello-grpc/proto"
	"google.golang.org/grpc"
	"google.golang.org/protobuf/types/known/emptypb"
	"log"
	"net"
	"time"
)

type HelloServer struct {
	pb.UnimplementedHelloServer
}

func (s *HelloServer) SayHello(c context.Context, r *pb.HelloRequest) (*pb.HelloResponse, error) {
	return &pb.HelloResponse{Message: fmt.Sprintf("Hello, %s!", r.Name)}, nil
}

func (s *HelloServer) ClockStream(_ *emptypb.Empty, css pb.Hello_ClockStreamServer) error {
	for {
		err := css.Send(&pb.ClockResponse{Datetime: fmt.Sprintf("Clock from server: %s", time.Now().Format(time.RFC3339))})
		if err != nil {
			return err
		}
		time.Sleep(time.Second)
	}
}

func main() {
	tcpServer, err := net.Listen("tcp", fmt.Sprintf(":%d", 6668))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	server := grpc.NewServer()
	pb.RegisterHelloServer(server, &HelloServer{})
	log.Printf("server listening at %v", tcpServer.Addr())
	err = server.Serve(tcpServer)
	if err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
