package main

import (
	"os"
	"time"

	"gioui.org/app"
	"gioui.org/io/system"
	"gioui.org/layout"
	"gioui.org/op"
	"gioui.org/unit"
	"gioui.org/widget"
	"gioui.org/widget/material"
)

var progress float32

func main() {
	go run()

	app.Main()
}

func run() {
	w := app.NewWindow(
		app.Title("Egg timer"),
		app.Size(unit.Dp(300), unit.Dp(450)),
	)

	ops := op.Ops{}
	strtBtn := widget.Clickable{}
	th := material.NewTheme()

	for e := range w.Events() {
		switch e := e.(type) {
		case system.FrameEvent:
			ctx := layout.NewContext(&ops, e)
			layout.Flex{
				Axis:    layout.Vertical,
				Spacing: layout.SpaceStart,
			}.Layout(
				ctx,
				layout.Rigid(
					func(gtx layout.Context) layout.Dimensions {
						bar := material.ProgressBar(th, progress) // Here progress is used
						return bar.Layout(gtx)
					}),
				layout.Rigid(
					func(gtx layout.Context) layout.Dimensions {
						margins := layout.Inset{
							Top:    unit.Dp(25),
							Bottom: unit.Dp(25),
							Right:  unit.Dp(35),
							Left:   unit.Dp(35),
						}
						return margins.Layout(gtx,
							func(gtx layout.Context) layout.Dimensions {
								btn := material.Button(th, &strtBtn, "Start")
								return btn.Layout(gtx)
							},
						)
					},
				),
			)
			e.Frame(ctx.Ops)
			time.Sleep(time.Millisecond * 17)
		case system.DestroyEvent:
			os.Exit(1)
		}
	}
	os.Exit(0)
}
