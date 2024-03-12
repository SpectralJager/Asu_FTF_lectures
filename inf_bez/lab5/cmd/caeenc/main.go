package main

import (
	"fmt"
	lab5 "infobez"
	"log"
	"os"
)

func main() {
	// encode model
	content, err := os.ReadFile("Model.txt")
	if err != nil {
		log.Fatal(err)
	}
	fmt.Print("Enter shift (from 0 to 30): ")
	var shift int
	fmt.Scanf("%d", &shift)

	encodedContent := lab5.CEAEncoder(string(content), shift)

	err = os.WriteFile("ModelEncodedCEA.txt", []byte(encodedContent), 0644)
	if err != nil {
		log.Fatal(err)
	}
}
