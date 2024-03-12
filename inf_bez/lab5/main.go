package main

import (
	"bytes"
	"fmt"
	"log"
	"os"
	"strings"
)

var alphabet = []rune("абвгдежзийклмнопрстуфхцчшщъыьэюя")

func main() {
	content := MustReadFile()
	mod := MustSelectMode()
	result := ""
	switch mod {
	case "vig":
		result = VIGEncoder(string(content), MustReadKey())
	case "cae":
		if MustIsDecode() {
			result = CEADecode(string(content))
		} else {
			result = CEAEncoder(string(content), MustReadShift())
		}
	default:
		log.Fatalln("wront mode")
	}
	MustWriteFile(result)
}

func MustReadFile() string {
	filepath := ""
	fmt.Print("Enter input file path: ")
	fmt.Scanf("%s", &filepath)
	content, err := os.ReadFile(filepath)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println("file readed...")
	return string(content)
}

func MustWriteFile(content string) {
	filepath := ""
	fmt.Print("Enter output file path: ")
	fmt.Scanf("%s", &filepath)
	err := os.WriteFile(filepath, []byte(content), 0644)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println("file writed...")
}

func MustSelectMode() string {
	mod := ""
	fmt.Print("Enter mod [cae|vig]: ")
	fmt.Scanf("%s", &mod)
	switch mod {
	case "cae", "vig":
		return mod
	default:
		return "cae"
	}
}

func MustReadShift() int {
	shift := 0
	fmt.Print("Enter shift: ")
	fmt.Scanf("%d", &shift)
	if shift < 0 || shift > len(alphabet) {
		return 0
	}
	return shift
}

func MustReadKey() string {
	key := ""
	fmt.Print("Enter key [rus lowercase symbols]: ")
	fmt.Scanf("%s", &key)
	if key == "" {
		return "ивт"
	}
	return key
}

func MustIsDecode() bool {
	isDecode := ""
	fmt.Print("Is decode [y|n]: ")
	fmt.Scanf("%s", &isDecode)
	return isDecode == "y"
}

func CEAEncoder(msg string, shift int) string {
	msg = strings.ToLower(msg)
	msgArray := []rune(msg)
	var outBuf bytes.Buffer
	for _, rn := range msgArray {
		res := MakeShift(rn, shift)
		outBuf.WriteRune(res)
	}
	return outBuf.String()
}

func CEADecode(msg string) string {
	for i := 0; i < len(alphabet); i++ {
		res := CEAEncoder(msg[:32], i)
		fmt.Printf("Shift #%d: %s...\n", i, res)
	}
	var shift int
	fmt.Print("Select mode: ")
	fmt.Scanf("%d", &shift)
	return CEAEncoder(msg, shift)
}

func VIGEncoder(msg string, key string) string {
	msg = strings.ToLower(msg)
	key = strings.ToLower(key)

	msgArray := []rune(msg)
	keyArray := []rune(key)

	var resBuf bytes.Buffer
	for i, ch := range msgArray {
		k := keyArray[i%len(keyArray)]
		resBuf.WriteRune(MakeShift(ch, int(k-alphabet[0])))
	}
	return resBuf.String()
}

func MakeShift(src rune, shift int) rune {
	if strings.ContainsAny(string(src), "\t ;,.:") {
		return '_'
	}
	if src > alphabet[len(alphabet)-1] || src < alphabet[0] {
		return src
	}
	index := (int(src-alphabet[0]) + shift) % len(alphabet)
	return alphabet[index]
}
