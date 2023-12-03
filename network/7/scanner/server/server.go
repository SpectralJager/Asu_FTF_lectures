package main

import (
	"bufio"
	"flag"
	"fmt"
	"log"
	"net"
	"os"
	"strings"
	"time"
)

var (
	address = flag.String("addr", "", "scann addresses ports")
)

const (
	listenPort = ":8080"
	connType   = "tcp"
)

func main() {
	flag.Parse()
	if *address == "" {
		fmt.Println("usage: ./scann -addr <addr>")
		fmt.Println("example: ./scann -addr 192.168.0.1")
		os.Exit(1)
	}
	data, err := scan(*address)
	if err != nil {
		log.Fatal(err)
	}
	log.Printf("recived:\n%s\n", data)
	os.Exit(0)
}

func scan(addr string) (string, error) {
	ip := strings.Split(addr, ":")[0]
	remoteAddr := ip + listenPort
	log.Printf("create remote address: %s", remoteAddr)
	conn, err := net.DialTimeout("tcp", remoteAddr, time.Second*10)
	if err != nil {
		return "", err
	}
	defer conn.Close()
	log.Println("connect to remote client")
	_, err = conn.Write([]byte("scan\x00"))
	if err != nil {
		return "", err
	}
	log.Println("send scan command to remote client")

	result, err := bufio.NewReader(conn).ReadString('\x00')
	result = result[:len(result)-1]
	return result, err
}
