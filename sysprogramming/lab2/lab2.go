package main

import (
	"fmt"
	"log"
	"os"
	"strconv"
	"strings"
)

const outPath = "lab2/output/output"

func parseLine(line string) (string, int, error) {
	log.Println(line)
	colons := strings.Split(line, " -> ")
	log.Println(colons)
	val, err := strconv.ParseInt(colons[1], 10, 64)
	return colons[0], int(val), err
}

func main() {
	buf, err := os.ReadFile(outPath)
	if err != nil {
		log.Fatal(err)
	}
	lines := strings.Split(string(buf), "\n")
	log.Println(lines)
	file, min, err := parseLine(lines[0])
	if err != nil {
		log.Fatal(err)
	}

	files := []string{file}

	for _, line := range lines[1:] {
		if line == "" {
			continue
		}
		file, val, err := parseLine(line)
		if err != nil {
			log.Fatal(err)
		}
		if min == val {
			files = append(files, file)
		} else if min > val {
			min = val
			files = []string{file}
		}
	}
	os.WriteFile(outPath+"2", []byte(fmt.Sprintf("%d -> %v", min, files)), 0644)
}
