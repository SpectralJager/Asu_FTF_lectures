package main

import (
	"log"
	"math"
	"runtime"
	"time"

	"github.com/go-gl/gl/v2.1/gl"
	"github.com/go-gl/glfw/v3.3/glfw"
)

const width, height = 1024, 800
const total = 100

var a float32 = 0

var sphere [][]point

type point struct {
	x, y, z float32
}

func getSphere(r float64) {
	for i := 0.0; i < total+1; i++ {
		lon := i*2.0*math.Pi/total - math.Pi
		sphere = append(sphere, make([]point, 0))
		for j := 0.0; j < total+1; j++ {
			lat := j*math.Pi/total - (math.Pi / 2)
			x := r * math.Sin(lon) * math.Cos(lat)
			y := r * math.Sin(lon) * math.Sin(lat)
			z := r * math.Cos(lon)
			sphere[int(i)] = append(sphere[int(i)], point{float32(x), float32(y), float32(z)})
		}
	}
}

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

	window.SetKeyCallback(func(w *glfw.Window, key glfw.Key, scancode int, action glfw.Action, mods glfw.ModifierKey) {})

	if err := gl.Init(); err != nil {
		panic(err)
	}

	gl.ShadeModel(gl.SMOOTH)
	gl.ClearColor(0.0, 0.0, 0.0, 1.0)
	gl.ClearDepth(1.0)
	gl.Enable(gl.DEPTH_TEST)
	gl.DepthFunc(gl.LEQUAL)
	gl.Hint(gl.PERSPECTIVE_CORRECTION_HINT, gl.NICEST)

	getSphere(0.8)

	for !window.ShouldClose() {
		gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)
		gl.LoadIdentity()
		draw()
		window.SwapBuffers()
		glfw.PollEvents()
		time.Sleep(time.Second / 30)
	}
}

func draw() {
	// gl.Scalef(.3, .3, .3)
	gl.Rotatef(a, 1, 1, 1)
	drawSphereT()
	gl.LoadIdentity()

	a += 1
}

func drawSphereT() {
	gl.Color3f(0.7, 0, 0)
	gl.Begin(gl.TRIANGLE_STRIP)
	for i := 0; i < total; i++ {
		for j := 0; j < total; j++ {
			if i%2 == 0 {
				gl.Color3f(0.7, 0, 0)
			} else {
				gl.Color3f(.7, 0, .7)
			}
			v0 := sphere[i][j]
			v1 := sphere[i][j+1]
			v2 := sphere[i+1][j]
			v3 := sphere[i+1][j+1]
			gl.Vertex3f(v0.x, v0.y, v0.z)
			gl.Vertex3f(v1.x, v1.y, v1.z)
			gl.Vertex3f(v2.x, v2.y, v2.z)
			gl.Vertex3f(v3.x, v3.y, v3.z)
		}
	}
	gl.End()
	// gl.Color3f(.7, .7, .7)
	// gl.Begin(gl.LINE_STRIP)
	// for i := 0; i < total; i++ {
	// 	for j := 0; j < total; j++ {
	// 		v0 := sphere[i][j]
	// 		v1 := sphere[i][j+1]
	// 		v2 := sphere[i+1][j]
	// 		v3 := sphere[i+1][j+1]
	// 		gl.Vertex3f(v0.x, v0.y, v0.z)
	// 		gl.Vertex3f(v1.x, v1.y, v1.z)
	// 		gl.Vertex3f(v2.x, v2.y, v2.z)
	// 		gl.Vertex3f(v3.x, v3.y, v3.z)
	// 	}
	// }
	// gl.End()
}

func drawSphereP() {
	gl.Color3f(1, 0, 0)
	gl.Begin(gl.POINTS)
	for i := 0; i < total; i++ {
		for j := 0; j < total; j++ {
			gl.Vertex3f(sphere[i][j].x, sphere[i][j].y, sphere[i][j].z)
		}
	}
	gl.End()
}
