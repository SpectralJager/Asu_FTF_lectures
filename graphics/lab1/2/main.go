package main

import (
	"fmt"
	"os"
	"strconv"

	"github.com/Pitrified/go-turtle"
)

func main() {
	it, err := strconv.ParseInt(os.Args[1], 10, 64)
	if err != nil {
		panic(err)
	}
	dragon(int(it))
}

func dragon(it int) {
	r := "r"
	l := "l"

	old := r
	new := old
	for i := 0; i < int(it); i++ {
		new = old + r
		old = reverse(old)
		for i, ch := range old {
			switch ch {
			case 'r':
				old = old[:i] + l + old[i+1:]
			case 'l':
				old = old[:i] + r + old[i+1:]
			}
		}
		new = new + old
		old = new
	}
	fmt.Printf("pattern: %s\nlen: %d", new, len(new))
	w := turtle.NewWorldWithColor(2000, 2000, turtle.Cyan)
	defer w.Close()
	t := turtle.NewTurtleDraw(w)
	t.SetPos(500, 1200)
	t.SetSize(1)
	t.SetHeading(turtle.West)
	t.SetColor(turtle.Red)
	t.PenDown()
	for _, k := range new {
		switch k {
		case 'l':
			t.Left(90)
		case 'r':
			t.Right(90)
		}
		t.Forward(10)
	}
	t.PenUp()
	err := w.SaveImage("dragon.png")
	if err != nil {
		panic(err)
	}

}

func reverse(s string) string {
	str := []byte(s)
	for i, j := 0, len(str)-1; i < j; i, j = i+1, j-1 {
		str[i], str[j] = str[j], str[i]
	}
	return string(str)
}
