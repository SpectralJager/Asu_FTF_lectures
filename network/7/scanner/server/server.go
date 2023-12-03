package main

import (
	"bytes"
	"context"
	"flag"
	"fmt"
	"io"
	"math/rand"
	"net"
	"os"
	"time"
)

var (
	listOfAddresses = flag.Bool("list", false, "get list of available addresses")
)

const (
	broadcast   = "192.168.0.255:8080"
	listenPort  = ":8080"
	connType    = "udp"
	letters     = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	magicLength = 10
)

func main() {
	flag.Parse()
	if listOfAddresses != nil {
		ctx, cancel := context.WithTimeout(context.Background(), time.Second*10)
		defer cancel()
		addresses, err := pingAddresses(ctx)
		if err != nil {
			fmt.Println(err.Error())
			os.Exit(1)
		}
		printAddresses(addresses)
	}
	os.Exit(0)
}

func pingAddresses(ctx context.Context) ([]string, error) {
	var addresses []string
	magicMsg := RandString(magicLength)
	err := pingBroadcast(ctx, magicMsg)
	listener, err := net.Listen(connType, listenPort)
	if err != nil {
		return addresses, err
	}
	ipsChan := make(chan string, 10)
	go func() {
		var buf bytes.Buffer
		for {
			buf.Reset()
			conn, err := listener.Accept()
			if err != nil {
				continue
			}
			defer conn.Close()
			io.Copy(&buf, conn)
			if buf.String() == magicMsg {
				ipsChan <- conn.RemoteAddr().String()
			}
		}
	}()
	for {
		select {
		case <-ctx.Done():
			close(ipsChan)
			return addresses, nil
		case address := <-ipsChan:
			addresses = append(addresses, address)
		}

	}
}

func pingBroadcast(ctx context.Context, magic string) error {
	conn, err := net.Dial(connType, broadcast)
	if err != nil {
		return err
	}
	defer conn.Close()
	_, err = conn.Write([]byte("ping:" + magic))
	if err != nil {
		return err
	}
	return nil
}

func printAddresses(addresses []string) {
	fmt.Println("available addresses:")
	for _, addr := range addresses {
		fmt.Printf("\t%s\n", addr)
	}
}

func RandString(n int) string {
	b := make([]byte, n)
	for i := range b {
		b[i] = letters[rand.Int63()%int64(len(letters))]
	}
	return string(b)
}
