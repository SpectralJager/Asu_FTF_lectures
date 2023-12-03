package main

import (
	"bufio"
	"bytes"
	"fmt"
	"log"
	"net"
	"os"
	"time"
)

const (
	listenPort = ":8080"
)

func main() {
	listener, err := net.Listen("tcp", listenPort)
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(1)
	}
	log.Println("starting client...")
	for {
		conn, err := listener.Accept()
		if err != nil {
			continue
		}
		msg, err := bufio.NewReader(conn).ReadString('\x00')
		if err != nil {
			continue
		}
		msg = msg[:len(msg)-1]
		log.Printf("[%s] receive command: %s", conn.RemoteAddr(), msg)
		if msg == "scan" {
			log.Printf("scan ports... ")
			ports := scan()
			log.Printf("send result to server... ")
			conn.Write([]byte(ports))
			conn.Write([]byte("\x00"))
			log.Printf("done!\n")
		} else {
			conn.Write([]byte("unknown command"))
		}
	}
}

func scan() string {
	var ports bytes.Buffer
	for i := 0; i < 65536; i++ {
		conn, err := net.DialTimeout("tcp", fmt.Sprintf(":%d", i), time.Second*1)
		if err != nil {
			continue
		}
		fmt.Fprintf(&ports, "port %d opended\n", i)
		defer conn.Close()
		fmt.Printf("\tport %d opened\n", i)
	}
	return ports.String()
}
