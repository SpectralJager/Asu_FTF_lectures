package main

import (
	"image"
	"image/jpeg"
	"math"
	"math/cmplx"
	"os"
	"strconv"
	"strings"

	"github.com/Pitrified/go-turtle"
)

func main() {
	it, err := strconv.ParseInt(os.Args[2], 10, 64)
	if err != nil {
		panic(err)
	}
	switch os.Args[1] {
	case "1.1":
		koch("f", int(it))
	case "1.2":
		koch("frfrf", int(it))
	case "1.3":
		dragon(int(it))
	case "1.4":
		const (
			dx = 20000
			dy = 20000
		)
		data := pc(dx, dy)
		m := image.NewNRGBA(image.Rect(0, 0, dx, dy))
		for y := 0; y < dy; y++ {
			for x := 0; x < dx; x++ {
				v := data[y][x]
				i := y*m.Stride + x*4
				m.Pix[i] = v
				m.Pix[i+1] = v
				m.Pix[i+2] = 255
				m.Pix[i+3] = 255
			}
		}
		f, err := os.Create("mand.jpg")
		if err != nil {
			panic(err)
		}
		defer f.Close()
		if err = jpeg.Encode(f, m, nil); err != nil {
			panic(err)
		}
	}
}

func mandelbrot(x, y float64) uint8 {
	z := (0.0 + 0.0i)
	c := complex(x, y)
	steps := uint8(0)
	for steps < 255 {
		zn := z*z + c
		r, _ := cmplx.Polar(zn)
		if (-2.0 < r) && (r < 2.0) {
			steps += 1
			z = zn
		} else {
			break
		}
	}
	return steps
}

func pc(dx, dy int) [][]uint8 {
	ys := make([][]uint8, dy)
	for y := 0; y < dy; y++ {
		ys[y] = make([]uint8, dx)
		for x := 0; x < dx; x++ {
			ys[y][x] = mandelbrot(
				mp(float64(x), 0.0, float64(dx), -2.0, 0.5),
				mp(float64(y), 0.0, float64(dy), -2.0, 0.5),
			)
		}
	}
	return ys
}

func mp(value, start1, stop1, start2, stop2 float64) float64 {
	return start2 + (stop2-start2)*((value-start1)/(stop1-start1))
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
	// fmt.Printf("pattern: %s\n", new)
	w := turtle.NewWorldWithColor(900, 900, turtle.Cyan)
	defer w.Close()
	t := turtle.NewTurtleDraw(w)
	t.SetPos(450, 450)
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

func koch(koch_flake string, it int) {
	// var koch_flake = "f"
	// var koch_flake = "frfrf"
	for i := 0; i < int(it); i++ {
		koch_flake = strings.ReplaceAll(koch_flake, "f", "flfrflf")
	}
	w := turtle.NewWorldWithColor(600, 600, turtle.Cyan)
	defer w.Close()
	t := turtle.NewTurtleDraw(w)
	t.SetPos(100, 300)
	t.SetSize(1)
	t.SetHeading(turtle.East)
	t.SetColor(turtle.Red)
	t.PenDown()
	for _, k := range koch_flake {
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
	err := w.SaveImage("koch.png")
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
