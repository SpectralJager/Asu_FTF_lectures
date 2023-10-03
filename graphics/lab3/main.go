package main

import (
	_ "image/png"
	"log"
	"runtime"
	"time"

	"github.com/go-gl/gl/v2.1/gl"
	"github.com/go-gl/glfw/v3.3/glfw"
)

const width, height = 450, 450
const scX, scY = 0.25, 0.25

var a float32 = 0.0
var flag = false

func main() {
	runtime.LockOSThread()
	if err := glfw.Init(); err != nil {
		log.Fatalln("failed to initialize glfw:", err)
	}
	defer glfw.Terminate()

	glfw.WindowHint(glfw.Resizable, glfw.False)
	glfw.WindowHint(glfw.ContextVersionMajor, 2)
	glfw.WindowHint(glfw.ContextVersionMinor, 1)
	window, err := glfw.CreateWindow(width, height, "Cube", nil, nil)
	if err != nil {
		panic(err)
	}
	window.MakeContextCurrent()

	window.SetKeyCallback(func(w *glfw.Window, key glfw.Key, scancode int, action glfw.Action, mods glfw.ModifierKey) {
		if key == glfw.KeyQ && action == glfw.Press {
			flag = !flag
		}
	})

	if err := gl.Init(); err != nil {
		panic(err)
	}

	gl.ShadeModel(gl.SMOOTH)
	gl.ClearColor(0.0, 0.0, 0.0, 1.0)
	gl.ClearDepth(1.0)
	gl.Enable(gl.DEPTH_TEST)
	gl.DepthFunc(gl.LEQUAL)
	gl.Hint(gl.PERSPECTIVE_CORRECTION_HINT, gl.NICEST)

	for !window.ShouldClose() {
		gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)
		gl.LoadIdentity()
		if flag {
			draw1()
		} else {
			draw2()
		}
		window.SwapBuffers()
		glfw.PollEvents()
		time.Sleep(time.Second / 30)
	}
}

func draw1() {
	gl.Scalef(scX, scY, 0.0)
	gl.Color3f(1, 1, 1)
	drawPolygon()
	gl.LoadIdentity()

	// 1: rotation 30, 60, 95
	gl.Scalef(scX, scY, 0.0)
	gl.Rotatef(-30, 0, 0, 1)
	gl.Color3f(0.3, 0.5, 0.2)
	drawPolygon()
	gl.LoadIdentity()

	gl.Scalef(scX, scY, 0.0)
	gl.Rotatef(-60, 0, 0, 1)
	drawPolygon()
	gl.LoadIdentity()

	gl.Scalef(scX, scY, 0.0)
	gl.Rotatef(-95, 0, 0, 1)
	drawPolygon()
	gl.LoadIdentity()

	// 2: mirronring x|y
	gl.Scalef(scX, scY, 0.0)
	gl.Rotatef(180, 1, 0, 0)
	gl.Color3f(0.5, 0.3, 0.2)
	drawPolygon()
	gl.LoadIdentity()

	gl.Scalef(scX, scY, 0.0)
	gl.Rotatef(180, 0, 1, 0)
	gl.Color3f(0.5, 0.3, 0.2)
	drawPolygon()
	gl.LoadIdentity()

	// 3: scaling 2:2, 1:4, 5:2
	gl.Scalef(scX, scY, 0.0)
	gl.Translatef(-0.0, -3.0, 0)
	gl.Scalef(2, 2, 0.0)
	gl.Color3f(0.3, 0.2, 0.5)
	drawPolygon()
	gl.LoadIdentity()

	gl.Scalef(scX, scY, 0.0)
	gl.Translatef(-0.8, -3.0, 0)
	gl.Scalef(1, 4, 0.0)
	gl.Color3f(0.3, 0.2, 0.5)
	drawPolygon()
	gl.LoadIdentity()

	gl.Scalef(scX, scY, 0.0)
	gl.Translatef(-6.0, -3.0, 0)
	gl.Scalef(5, 2, 0.0)
	gl.Color3f(0.3, 0.2, 0.5)
	drawPolygon()
	gl.LoadIdentity()

	// 4: 2x+2
	gl.Scalef(scX, scY, 0.0)
	gl.Color3f(1, 0, 0)
	gl.Rotatef(180, 0, 1, 0)
	gl.Rotatef(45, 0, 0, 1)
	drawPolygon()
	gl.LoadIdentity()
}

func draw2() {
	gl.Scalef(scX, scY, 0.0)
	gl.Color3f(1, 1, 1)
	drawPolygon()
	gl.LoadIdentity()

	gl.Scalef(scX, scY, 0.0)
	gl.Color3f(1, 0, 0)
	gl.Translatef(-1.0, 0.0, 0.0)
	gl.Rotatef(-30, 0, 1, 0)
	gl.Rotatef(30, 0, 0, 1)
	drawPolygon()
	gl.LoadIdentity()

	gl.Scalef(scX, scY, 0.0)
	gl.Color3f(0, 1, 0)
	gl.Translatef(-2.0, 0.0, 0.0)
	gl.Rotatef(-30, 1, 0, 0)
	gl.Rotatef(30, 0, 0, 1)
	drawPolygon()

	gl.Color3f(1, 0, 1)
	gl.Translatef(-1.0, 0.0, 0.0)
	gl.Rotatef(45, 1, 0, 0)
	gl.Rotatef(45, 0, 1, 0)
	drawPolygon()
	gl.LoadIdentity()
}

func drawPolygon() {
	gl.Begin(gl.TRIANGLES)
	gl.Vertex3f(0.4, 0.4, 0.0)
	gl.Vertex3f(0.7, 0.6, 0.0)
	gl.Vertex3f(1.0, 0.4, 0.0)

	gl.Vertex3f(0.4, 0.4, 0.0)
	gl.Vertex3f(1.0, 0.4, 0.0)
	gl.Vertex3f(0.7, 0.3, 0.0)

	gl.Vertex3f(0.4, 0.4, 0.0)
	gl.Vertex3f(0.7, 0.3, 0.0)
	gl.Vertex3f(0.6, 0.1, 0.0)

	gl.Vertex3f(1.0, 0.4, 0.0)
	gl.Vertex3f(0.7, 0.3, 0.0)
	gl.Vertex3f(0.8, 0.1, 0.0)
	gl.End()
}
