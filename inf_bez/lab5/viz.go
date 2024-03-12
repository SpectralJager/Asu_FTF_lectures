package lab5

import (
	"bytes"
	"log"
	"os"
	"strings"
)

func VIG() {
	// encode model
	content, err := os.ReadFile("Model.txt")
	if err != nil {
		log.Fatal(err)
	}

	encodedContent := VIGEncoder(string(content), "ивт")

	err = os.WriteFile("ModelEncodedVIG.txt", []byte(encodedContent), 0644)
	if err != nil {
		log.Fatal(err)
	}
}

func VIGEncoder(msg string, key string) string {
	msg = strings.ToLower(msg)
	key = strings.ToLower(key)

	msgArray := []rune(msg)
	keyArray := []rune(key)

	var resBuf bytes.Buffer
	for i, ch := range msgArray {
		k := keyArray[i%len(keyArray)]
		resBuf.WriteRune(MakeShift(ch, int(k-BeginLow)))
	}
	return resBuf.String()
}

func VIGDecode(msg string) string {
	return ""
}
