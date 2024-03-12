package lab5

import (
	"bytes"
	"fmt"
	"strings"
)

func CEAEncoder(msg string, shift int) string {
	msg = strings.ToLower(msg)
	msgArray := []rune(msg)
	var outBuf bytes.Buffer
	for _, rn := range msgArray {
		outBuf.WriteRune(MakeShift(rn, shift))
	}
	return outBuf.String()
}

func CEADecode(msg string) string {
	for i := 0; i < EndLow-BeginLow; i++ {
		res := CEAEncoder(msg[:32], i)
		fmt.Printf("Shift #%d: %s...\n", i, res)
	}
	var shift int
	fmt.Print("Select mode: ")
	fmt.Scanf("%d", &shift)
	return CEAEncoder(msg, shift)
}
