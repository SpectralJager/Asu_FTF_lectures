package main

import (
	"bufio"
	"bytes"
	"fmt"
	"image/png"
	"io"
	"log"
	"os"

	"github.com/auyer/steganography"
)

func main() {
	rd := MustReadFile()
	if MustSelectMode() {
		Decode(rd)
	} else {
		Encode(rd, MustReadMessage())
	}
	fmt.Println("done")
}

func MustReadFile() io.Reader {
	filepath := ""
	fmt.Print("Enter input file path: ")
	fmt.Scanf("%s", &filepath)
	inFile, err := os.Open("lab6.png")
	if err != nil {
		log.Fatal(err)
	}
	return inFile
}

func MustReadMessage() string {
	msg := ""
	fmt.Print("Enter message: ")
	fmt.Scanf("%s", &msg)
	if msg == "" {
		return "hello, world"
	}
	return msg
}

func MustSelectMode() bool {
	isDecode := ""
	fmt.Print("Is decode [y|n]: ")
	fmt.Scanf("%s", &isDecode)
	return isDecode == "y"
}

func Decode(input io.Reader) {
	reader := bufio.NewReader(input)
	img, err := png.Decode(reader)
	if err != nil {
		log.Fatal(err)
	}
	sizeOfMessage := steganography.GetMessageSizeFromImage(img)

	msg := steganography.Decode(sizeOfMessage, img)
	fmt.Println("Message: ", string(msg))
}

func Encode(input io.Reader, msg string) {
	reader := bufio.NewReader(input)
	img, err := png.Decode(reader)
	if err != nil {
		log.Fatal(err)
	}

	w := new(bytes.Buffer)
	err = steganography.Encode(w, img, []byte(msg))
	if err != nil {
		log.Printf("Error Encoding file %v", err)
		return
	}

	outFile, err := os.Create("out_file.png")
	if err != nil {
		log.Fatal(err)
	}
	defer outFile.Close()

	_, err = w.WriteTo(outFile)
	if err != nil {
		log.Fatal(err)
	}
}
