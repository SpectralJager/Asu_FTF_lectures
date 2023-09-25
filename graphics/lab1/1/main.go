package main

import (
	"math"
	"os"
	"strconv"
	"strings"

	"github.com/Pitrified/go-turtle"
)

func main() {
	it, _ := strconv.ParseInt(os.Args[1], 10, 64)
	thriad(int(it))
	quad(int(it))
}

func thriad(it int) {
	var pattern = "f"
	for i := 0; i < int(it); i++ {
		pattern = strings.ReplaceAll(pattern, "f", "flfrflf")
	}
	w := turtle.NewWorldWithColor(600, 600, turtle.Cyan)
	defer w.Close()
	t := turtle.NewTurtleDraw(w)
	t.SetPos(100, 300)
	t.SetSize(1)
	t.SetHeading(turtle.East)
	t.SetColor(turtle.Red)
	t.PenDown()
	for _, k := range pattern {
		switch k {
		case 'f':
			t.Forward(100.0 / (math.Pow(3, (float64(it - 1)))))
		case 'l':
			t.Left(60)
		case 'r':
			t.Right(120)
		}
	}
	t.PenUp()
	err := w.SaveImage("koch1.png")
	if err != nil {
		panic(err)
	}
}

func quad(it int) {
	var pattern = "f"
	for i := 0; i < int(it); i++ {
		pattern = strings.ReplaceAll(pattern, "f", "flfrfrflf")
	}
	w := turtle.NewWorldWithColor(600, 600, turtle.Cyan)
	defer w.Close()
	t := turtle.NewTurtleDraw(w)
	t.SetPos(100, 300)
	t.SetSize(1)
	t.SetHeading(turtle.East)
	t.SetColor(turtle.Red)
	t.PenDown()
	for _, k := range pattern {
		switch k {
		case 'f':
			t.Forward(100.0 / (math.Pow(3, (float64(it - 1)))))
		case 'l':
			t.Left(90)
		case 'r':
			t.Right(90)
		}
	}
	t.PenUp()
	err := w.SaveImage("koch2.png")
	if err != nil {
		panic(err)
	}
}
