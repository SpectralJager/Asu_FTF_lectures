package main

import (
	"bufio"
	"fmt"
	"log"
	"net"
	"os"
	"strings"
)

func main() {
	recvChan := make(chan string, 20)
	sendChan := make(chan string, 2)
	go recv(recvChan)
	go read(sendChan)
	for {
		select {
		case msg := <-recvChan:
			fmt.Print(msg)
		case msg := <-sendChan:
			go send(msg)
		}
	}
}

func read(ch chan string) {
	for {
		reader := bufio.NewReader(os.Stdin)
		text, _ := reader.ReadString('\n')
		ch <- text
	}
}

func recv(ch chan string) {
	server, err := net.ListenPacket("udp", ":8080")
	if err != nil {
		panic(err)
	}
	defer server.Close()

	for {
		buf := make([]byte, 2048)
		l, addr, err := server.ReadFrom(buf)
		if err != nil || l == 0 {
			continue
		}
		ch <- fmt.Sprintf("[%s] %s", strings.Split(addr.String(), ":")[0], buf)
	}
}

func send(msg string) {
	con, err := net.Dial("udp", "192.168.0.255:8080")
	if err != nil {
		log.Println(err.Error())
		return
	}
	_, err = con.Write([]byte(msg))
	if err != nil {
		log.Println(err.Error())
		return
	}
}
