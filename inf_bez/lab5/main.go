package main

import (
	"bufio"
	"bytes"
	"errors"
	"fmt"
	"io"
	"log"
	"os"
)

const (
	CESShift = 8
	BeginUp  = 'А'
	EndUp    = 'Я'
	BeginLow = 'а'
	EndLow   = 'я'
)

var (
	DefFreq = map[rune]float64{
		'о': 10.01,
		'а': 9.62,
		'е': 8.195,
		'и': 6.867,
		'т': 6.759,
		'н': 6.227,
		'л': 5.037,
		'р': 4.893,
		'с': 4.837,
		'в': 3.71,
		'к': 3.457,
		'м': 3.331,
		'д': 3.072,
		'у': 3.036,
		'п': 2.617,
		'б': 2.112,
		'г': 1.9,
		'ы': 1.695,
		'ч': 1.686,
		'ь': 1.682,
		'з': 1.481,
		'я': 1.418,
		'й': 1.274,
		'х': 1.031,
		'ж': 0.872,
		'ш': 0.836,
		'ю': 0.558,
		'ф': 0.497,
		'э': 0.481,
		'щ': 0.289,
		'ё': 0.255,
		'ц': 0.247,
		'ъ': 0.013,
	}
)

func main() {
	// encode model
	handler1, err := os.Open("Model.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer handler1.Close()

	data := CESEncoder(handler1)

	err = os.WriteFile("ModelEncoded.txt", []byte(data), 0644)
	if err != nil {
		log.Fatal(err)
	}

	// decode model
	handler2, err := os.Open("ModelEncoded.txt")
	if err != nil {
		log.Fatal(err)
	}
	defer handler1.Close()

	data = CESDecode(handler2)

	err = os.WriteFile("ModelDecoded.txt", []byte(data), 0644)
	if err != nil {
		log.Fatal(err)
	}
}

func CESEncoder(reader io.Reader) string {
	inBuf := bufio.NewReader(reader)
	var outBuf bytes.Buffer
	for {
		rn, _, err := inBuf.ReadRune()
		rn = ToLower(rn)
		if err != nil {
			if errors.Is(err, io.EOF) {
				break
			}
			log.Fatal(err)
		}
		outBuf.WriteRune(CESMakeShift(rn, CESShift))
	}

	return outBuf.String()
}

func CESDecode(reader io.Reader) string {
	inBuf := bufio.NewReader(reader)
	var outBuf bytes.Buffer
	for i := 0; i < 33; i++ {
		outBuf.Reset()
		ResetBuf(inBuf)
		for inBuf.Size() < 20 {
			rn, _, err := inBuf.ReadRune()
			rn = ToLower(rn)
			if err != nil {
				if errors.Is(err, io.EOF) {
					break
				}
				log.Fatal(err)
			}
			outBuf.WriteRune(CESMakeShift(rn, i))
		}
		fmt.Printf("Shift: %d, Decoded: %s...\n", i, outBuf.String())
	}
	return outBuf.String()
}

func CESMakeShift(src rune, shift int) rune {
	res := src
	if res+CESShift <= EndLow && res >= BeginLow {
		res = src + rune(shift)
	} else if res <= EndLow && res+rune(shift) >= BeginLow {
		res = src + rune(shift) - (EndLow - BeginLow)
	}
	return res
}

func ToLower(src rune) rune {
	if src >= BeginUp && src <= EndUp {
		return BeginLow + (src - BeginUp)
	}
	return src
}

func ResetBuf(bf *bufio.Reader) {
	for bf.Buffered() > 0 {
		bf.UnreadRune()
	}
}
