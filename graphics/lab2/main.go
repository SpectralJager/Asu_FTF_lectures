package main

import (
	"fmt"
	"image"
	"os"
	"time"

	g "github.com/AllenDang/giu"
	"golang.org/x/image/bmp"
)

var (
	img    image.Image
	rgba   *image.RGBA
	status string
	tex    g.Texture
)

func main() {
	file, err := os.Open("2.bmp")
	if err != nil {
		panic(err)
	}
	img, err = bmp.Decode(file)
	if err != nil {
		panic(err)
	}
	bounds := img.Bounds()
	rgba = g.ImageToRgba(img)

	w := g.NewMasterWindow("lab 2", bounds.Max.X, bounds.Max.Y+100, g.MasterWindowFlagsNotResizable)
	g.EnqueueNewTextureFromRgba(rgba, func(t *g.Texture) {
		tex = *t
	})
	w.Run(Loop)
}

func Loop() {
	g.SingleWindow().Layout(
		g.Image(&tex).Size(float32(img.Bounds().Dx()), float32(img.Bounds().Dy())),
		g.Event().OnHover(func() {
			pos := g.GetMousePos()
			clr := rgba.At(pos.X, pos.Y)
			status = fmt.Sprint(clr)
		}),
		g.Label(status),
	)
	time.Sleep(time.Second / 24)
}
