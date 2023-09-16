package main

import (
	"fmt"
	"io"
	"log"
	"os"
	"strings"
)

func main() {
	var inputPath = os.Args[1]
	var outPath = os.Args[2]
	dentry, err := os.ReadDir(inputPath)
	if err != nil {
		log.Println(err)
		os.Exit(1)
	}
	outFile, err := os.OpenFile(outPath, os.O_RDWR|os.O_CREATE, 0644)
	if err != nil {
		panic(err)
	}
	defer outFile.Close()
	for _, entry := range dentry {
		if entry.Name() == ".." || entry.Name() == "." || entry.IsDir() {
			continue
		}

		file, err := os.Open(inputPath + entry.Name())
		if err != nil {
			log.Println(err)
			os.Exit(2)
		}
		defer file.Close()
		data, err := io.ReadAll(file)
		if err != nil {
			log.Println(err)
			os.Exit(3)
		}
		count := strings.Count(string(data), " ") +
			strings.Count(string(data), "\t")
		io.WriteString(outFile, fmt.Sprintf("%s -> %d\n", inputPath+entry.Name(), count))
	}
}
