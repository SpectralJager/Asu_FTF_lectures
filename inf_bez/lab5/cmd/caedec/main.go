package main

import (
	lab5 "infobez"
	"log"
	"os"
)

func main() {
	// decode model
	content, err := os.ReadFile("ModelEncodedCEA.txt")
	if err != nil {
		log.Fatal(err)
	}

	decodedContent := lab5.CEADecode(string(content))

	err = os.WriteFile("ModelDecodedCEA.txt", []byte(decodedContent), 0644)
	if err != nil {
		log.Fatal(err)
	}
}
