package main

import (
	"fmt"
	"image"
	"image/color"
	"log"
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
	image       image.Image
	insideImage bool
	status      string
	th          *material.Theme
	btnToGrey   widget.Clickable
	btnToBlack  widget.Clickable
}

func NewState() *state {
	return &state{
		status: "R: nil, G: nil, B: nil",
		th:     material.NewTheme(),
	}
}

func (s *state) LoadImage(path string) {
	file, err := os.Open(path)
	if err != nil {
		panic(err)
	}
	img, _ := bmp.Decode(file)
	s.image = img
}

func main() {
	st := NewState()
	st.LoadImage("1.bmp")
	go func() {
		w := app.NewWindow(
			app.MinSize(unit.Dp(500), unit.Dp(600)),
			app.MaxSize(unit.Dp(500), unit.Dp(600)),
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
	layout.Flex{Axis: layout.Vertical}.Layout(
		gtx,
		layout.Rigid(func(gtx layout.Context) layout.Dimensions {
			return doImg(gtx, st, image.Rect(0, 0, 500, 500))
		}),
		layout.Rigid(func(gtx layout.Context) layout.Dimensions {
			return material.Body1(st.th, st.status).Layout(gtx)

		}),
		layout.Rigid(func(gtx layout.Context) layout.Dimensions {
			if st.btnToGrey.Clicked() {
				log.Println("to grey")
			}
			return material.Button(st.th, &st.btnToGrey, "Grey").Layout(gtx)
		}),
		layout.Rigid(func(gtx layout.Context) layout.Dimensions {
			return drawRect(gtx, image.Rect(0, 0, 0, 10), color.NRGBA{})
		}),
		layout.Rigid(func(gtx layout.Context) layout.Dimensions {
			if st.btnToBlack.Clicked() {
				log.Println("to black")
			}
			return material.Button(st.th, &st.btnToBlack, "Black").Layout(gtx)
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
				col := st.image.At(x.Position.Round().X, x.Position.Round().Y)
				r, g, b, _ := col.RGBA()
				st.status = fmt.Sprintf("R: 0x%X, G: 0x%X, B: 0x%X", uint8(r), uint8(g), uint8(b))
			}
		}
	}
	defer clip.Rect{Max: rect.Max}.Push(gtx.Ops).Pop()
	pointer.InputOp{
		Tag:   st.insideImage,
		Types: pointer.Enter | pointer.Leave | pointer.Move,
	}.Add(gtx.Ops)
	return drawImage(gtx, st.image, rect)
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
