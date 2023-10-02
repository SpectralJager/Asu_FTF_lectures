package main

import (
	"fmt"
	"image"
	"image/color"
	"os"
	"time"

	"gioui.org/app"
	"gioui.org/io/pointer"
	"gioui.org/io/system"
	"gioui.org/layout"
	"gioui.org/op"
	"gioui.org/op/clip"
	"gioui.org/op/paint"
	"gioui.org/unit"
	"gioui.org/widget"
	"gioui.org/widget/material"
	"golang.org/x/image/bmp"
)

type state struct {
	origImage   image.Image
	insideImage bool
	statusRGB   string
	statusHSV   string
	th          *material.Theme
	btnToGrey   widget.Clickable
	btnToBlack  widget.Clickable
	btnRefresh  widget.Clickable
	newImage    image.Image
}

func NewState() *state {
	return &state{
		statusRGB: "R: nil, G: nil, B: nil",
		statusHSV: "H: nil\nS: nil\nV: nil\n",
		th:        material.NewTheme(),
	}
}

func (s *state) LoadImage(path string) {
	file, err := os.Open(path)
	if err != nil {
		panic(err)
	}
	img, _ := bmp.Decode(file)
	s.origImage = img
	s.newImage = img
}

func main() {
	st := NewState()
	st.LoadImage("1.bmp")
	go func() {
		w := app.NewWindow(
			app.MinSize(unit.Dp(700), unit.Dp(500)),
			app.MaxSize(unit.Dp(700), unit.Dp(500)),
			app.Title("Graphics"),
		)
		if err := loop(w, st); err != nil {
			panic(err)
		}
		os.Exit(0)
	}()
	app.Main()
}

func loop(w *app.Window, st *state) error {
	for {
		select {
		case e := <-w.Events():
			switch e := e.(type) {
			case system.DestroyEvent:
				return e.Err
			case system.FrameEvent:
				gtx := layout.NewContext(&op.Ops{}, e)
				draw(gtx, st)
				e.Frame(gtx.Ops)
			}
		}
		time.Sleep(time.Second / 25)
	}
}

func draw(gtx layout.Context, st *state) {
	layout.Flex{Axis: layout.Horizontal}.Layout(
		gtx,
		layout.Rigid(func(gtx layout.Context) layout.Dimensions {
			layout.Flex{Axis: layout.Vertical}.Layout(
				gtx,
				layout.Rigid(func(gtx layout.Context) layout.Dimensions {
					return material.Body2(st.th, st.statusRGB).Layout(gtx)
				}),
				layout.Rigid(func(gtx layout.Context) layout.Dimensions {
					return drawRect(gtx, image.Rect(0, 0, 0, 10), color.NRGBA{})
				}),
				layout.Rigid(func(gtx layout.Context) layout.Dimensions {
					return material.Subtitle2(st.th, st.statusHSV).Layout(gtx)
				}),
				layout.Rigid(func(gtx layout.Context) layout.Dimensions {
					return drawRect(gtx, image.Rect(0, 0, 0, 10), color.NRGBA{})
				}),
				layout.Rigid(func(gtx layout.Context) layout.Dimensions {
					if st.btnToGrey.Clicked() {
						newImg := image.NewRGBA(st.origImage.Bounds())
						for x := 0; x < st.origImage.Bounds().Dx(); x++ {
							for y := 0; y < st.origImage.Bounds().Dy(); y++ {
								px := st.origImage.At(x, y)
								// r, g, b, _ := px.RGBA()
								// w := 0.299*float64(r) + 0.587*float64(g) + 0.114*float64(b)
								// newImg.Set(x, y, color.Gray{uint8(w / 255)})
								newImg.Set(x, y, color.GrayModel.Convert(px))
							}
						}
						st.newImage = newImg
					}
					return material.Button(st.th, &st.btnToGrey, "To Grey").Layout(gtx)
				}),
				layout.Rigid(func(gtx layout.Context) layout.Dimensions {
					return drawRect(gtx, image.Rect(0, 0, 0, 10), color.NRGBA{})
				}),
				layout.Rigid(func(gtx layout.Context) layout.Dimensions {
					if st.btnToBlack.Clicked() {
						newImg := image.NewRGBA(st.origImage.Bounds())
						for x := 0; x < st.origImage.Bounds().Dx(); x++ {
							for y := 0; y < st.origImage.Bounds().Dy(); y++ {
								px := st.origImage.At(x, y)
								r, g, b, _ := px.RGBA()
								w := 0.299*float64(r) + 0.587*float64(g) + 0.114*float64(b)
								var cl color.Color
								if uint16(w) > 0xa000 {
									cl = color.Black
								} else {
									cl = color.White
								}
								newImg.Set(x, y, cl)
								// return Pixel(uint16(y) < 0x8000)
							}
						}
						st.newImage = newImg
					}
					return material.Button(st.th, &st.btnToBlack, "To Black").Layout(gtx)
				}),
				layout.Rigid(func(gtx layout.Context) layout.Dimensions {
					return drawRect(gtx, image.Rect(0, 0, 0, 10), color.NRGBA{})
				}),
				layout.Rigid(func(gtx layout.Context) layout.Dimensions {
					if st.btnRefresh.Clicked() {
						st.newImage = st.origImage
					}
					return material.Button(st.th, &st.btnRefresh, "Refresh").Layout(gtx)
				}),
			)
			return layout.Dimensions{Size: image.Pt(200, 500)}

		}),
		layout.Rigid(func(gtx layout.Context) layout.Dimensions {
			return doImg(gtx, st, image.Rect(0, 0, 500, 500))
		}),
	)
}

func doImg(gtx layout.Context, st *state, rect image.Rectangle) layout.Dimensions {
	for _, ev := range gtx.Events(st.insideImage) {
		if x, ok := ev.(pointer.Event); ok {
			switch x.Type {
			case pointer.Enter:
				st.insideImage = true
			case pointer.Leave:
				st.insideImage = false
			case pointer.Move:
				col := st.newImage.At(x.Position.Round().X, x.Position.Round().Y)
				r, g, b, _ := col.RGBA()
				st.statusRGB = fmt.Sprintf("R: 0x%X, G: 0x%X, B: 0x%X", uint8(r), uint8(g), uint8(b))
				st.statusHSV = rgbTohsv(col)
			}
		}
	}
	defer clip.Rect{Max: rect.Max}.Push(gtx.Ops).Pop()
	pointer.InputOp{
		Tag:   st.insideImage,
		Types: pointer.Enter | pointer.Leave | pointer.Move,
	}.Add(gtx.Ops)
	return drawImage(gtx, st.newImage, rect)
}

func drawRRect(gtx layout.Context, rect image.Rectangle, r int, color color.NRGBA) layout.Dimensions {
	cl := clip.RRect{Rect: rect, SE: r, SW: r, NW: r, NE: r}
	defer cl.Push(gtx.Ops).Pop()
	return drawRect(gtx, rect, color)
}

func drawRect(gtx layout.Context, rect image.Rectangle, color color.NRGBA) layout.Dimensions {
	cl := clip.Rect{Min: rect.Min, Max: rect.Max}
	defer cl.Push(gtx.Ops).Pop()
	paint.ColorOp{Color: color}.Add(gtx.Ops)
	paint.PaintOp{}.Add(gtx.Ops)
	return layout.Dimensions{Size: rect.Max}
}

func drawImage(gtx layout.Context, img image.Image, rect image.Rectangle) layout.Dimensions {
	cl := clip.Rect{Min: rect.Min, Max: rect.Max}
	defer cl.Push(gtx.Ops).Pop()
	imgOp := paint.NewImageOp(img)
	imgOp.Add(gtx.Ops)
	// op.Affine(f32.Affine2D{}.Scale(f32.Pt(0, 0), f32.Pt(0.5, 0.5))).Add(gtx.Ops)
	paint.PaintOp{}.Add(gtx.Ops)
	return layout.Dimensions{Size: rect.Max}
}

func rgbTohsv(cl color.Color) string {
	tr, tg, tb, _ := cl.RGBA()
	var r, g, b, h, s, v float64
	r = float64(uint8(tr)) / 255.0
	g = float64(uint8(tg)) / 255.0
	b = float64(uint8(tb)) / 255.0
	mx := max(r, g, b)
	mn := min(r, g, b)

	v = mx
	delta := mx - mn
	if delta < 0.00001 {
		s = 0
		h = 0
		return fmt.Sprintf("H: %f\nS: %f\nV: %f\n", h, s, v)
	}
	if mx > 0.0 {
		s = delta / mx
	} else {
		s = 0
		h = 0
		return fmt.Sprintf("H: %f\nS: %f\nV: %f\n", h, s, v)
	}
	if r >= mx {
		h = (g - b) / delta
	} else if g >= mx {
		h = 2.0 + (b-r)/delta
	} else {
		h = 4.0 + (r-g)/delta
	}
	h *= 60.0
	if h < 0.0 {
		h += 360
	}
	return fmt.Sprintf("H: %f\nS: %f\nV: %f\n", h, s, v)
}

func max(args ...float64) float64 {
	var m float64 = 0
	for _, v := range args {
		if m < v {
			m = v
		}
	}
	return m
}

func min(args ...float64) float64 {
	var m float64 = args[0]
	for _, v := range args {
		if m > v {
			m = v
		}
	}
	return m
}
