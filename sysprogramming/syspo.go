package main

import (
	"log"
	"os"
	"os/exec"
)

func main() {
	switch os.Args[1] {
	case "1":
		cmd := exec.Command("lab1/lab1", "lab1/input/", "lab1/output/output")
		if err := cmd.Run(); err != nil {
			log.Fatal(err)
		}
	case "2":
		cmd := exec.Command("lab1/lab1", "lab1/input/", "lab2/output/output")
		if err := cmd.Run(); err != nil {
			log.Fatal(err)
		}
		cmd = exec.Command("lab2/lab2")
		if err := cmd.Run(); err != nil {
			log.Fatal(err)
		}
	case "3.1":
		cmd := exec.Command("lab3.1/reader/rd", "lab3/input/", "lab3/output/output")
		if err := cmd.Run(); err != nil {
			log.Fatal(err)
		}
	default:
		log.Fatal("unknown command ", os.Args[1])

	}
}
