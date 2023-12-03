package main

import (
	"bytes"
	"fmt"
	"io"
	"net"
	"os"
	"strings"
)

const (
	listenPort = ":8080"
	connType   = "udp"
)

func main() {
	var buf bytes.Buffer
	listener, err := net.Listen(connType, listenPort)
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(1)
	}
	for {
		buf.Reset()
		conn, err := listener.Accept()
		if err != nil {
			continue
		}
		defer conn.Close()
		io.Copy(&buf, conn)
		command := strings.Split(buf.String(), ":")
		if len(command) != 2 {
			continue
		}
		switch command[0] {
		case "ping":
			backConn, err := net.Dial(connType, conn.RemoteAddr().String())
			if err != nil {
				continue
			}
			backConn.Write([]byte(command[1]))
			backConn.Close()
		case "scan":
		}
	}
}
