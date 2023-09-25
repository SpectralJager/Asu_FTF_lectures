package main

import (
	"image"
	"image/png"
	"math/cmplx"
	"os"
)

func main() {
	img := draw(4000, 3000, 255)
	file, _ := os.Create("mand.png")
	png.Encode(file, img)
}

func draw(width, height, maxIt int) image.Image {
	img := image.NewGray(image.Rect(0, 0, width, height))
	minRe := -2.0
	minIm := -1.0
	maxRe := 1.0
	maxIm := 1.0
	reStep := (maxRe - minRe) / float64(width)
	imStep := (maxIm - minIm) / float64(height)
	re := minRe
	for ; re < maxRe; re += reStep {
		im := minIm
		for ; im < maxIm; im += imStep {
			res := belongs(float64(re), float64(im), maxIt)
			x := int((re - minRe) / reStep)
			y := int((im - minIm) / imStep)
			if res {
				pix := y*img.Stride + x
				img.Pix[pix] = 128
			} else {
			}
		}
	}
	return img
}

func belongs(re, im float64, it int) bool {
	z := complex(0, 0)
	c := complex(re, im)
	i := 0
	for i = 0; cmplx.Abs(z) < 4 && i < it; i++ {
		z = z*z + c
	}
	return i == it
}
