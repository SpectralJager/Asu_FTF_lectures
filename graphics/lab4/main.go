package main

import (
	"image/color"
	"log"
	"math"
	"runtime"
	"time"

	"github.com/go-gl/gl/v2.1/gl"
	"github.com/go-gl/glfw/v3.3/glfw"
)

const width, height = 1800, 1024
const total = 10

var a float32 = 0
var mat_specular []float32 = []float32{1, 0, 0, .2}
var mat_shinnes []float32 = []float32{80}
var light_pos []float32 = []float32{0, 0, .1, .1}

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

	// gl.Materialfv(gl.FRONT, gl.SPECULAR, &mat_specular[0])
	// gl.Materialfv(gl.FRONT, gl.SHININESS, &mat_shinnes[0])
	// gl.Lightfv(gl.LIGHT0, gl.POSITION, &light_pos[0])

	// gl.Enable(gl.LIGHTING)
	// gl.Enable(gl.LIGHT0)

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
	gl.Rotatef(a, .2, .6, .3)
	gl.Scalef(.1, .1, .1)
	drawSphereT(color.RGBA{202, 135, 1, 255})
	gl.LoadIdentity()

	gl.Rotatef(a*4, 0, .5, .5)
	gl.Translatef(0.15, 0, 0)
	gl.Scalef(.04, .04, .04)
	drawSphereT(color.RGBA{181, 161, 129, 255})
	gl.LoadIdentity()

	gl.Rotatef(a*3, 0, .5, .5)
	gl.Translatef(0.25, 0, 0)
	gl.Scalef(.05, .05, .05)
	drawSphereT(color.RGBA{240, 188, 89, 255})
	gl.LoadIdentity()

	gl.Rotatef(a*2, 0, .5, .5)
	gl.Translatef(0.38, 0, 0)
	gl.Scalef(.06, .06, .06)
	drawSphereT(color.RGBA{160, 167, 136, 255})
	gl.LoadIdentity()

	gl.Rotatef(a*1.7, 0, .5, .5)
	gl.Translatef(0.5, 0, 0)
	gl.Scalef(.05, .05, .05)
	drawSphereT(color.RGBA{211, 177, 148, 255})
	gl.LoadIdentity()

	gl.Rotatef(a*1.4, 0, .5, .5)
	gl.Translatef(0.64, 0, 0)
	gl.Scalef(.1, .1, .1)
	drawSphereT(color.RGBA{148, 117, 77, 255})
	gl.LoadIdentity()

	gl.Rotatef(a*1, 0, .5, .5)
	gl.Translatef(0.82, 0, 0)
	gl.Scalef(.1, .1, .1)
	drawSphereT(color.RGBA{255, 244, 200, 255})
	gl.LoadIdentity()

	gl.Rotatef(a*.8, 0, .5, .5)
	gl.Translatef(.95, 0, 0)
	gl.Scalef(.06, .06, .06)
	drawSphereT(color.RGBA{198, 220, 228, 255})
	gl.LoadIdentity()

	gl.Rotatef(a*.5, 0, .5, .5)
	gl.Translatef(1.1, 0, 0)
	gl.Scalef(.06, .06, .06)
	drawSphereT(color.RGBA{163, 196, 255, 255})
	gl.LoadIdentity()

	a += 1
}

func drawSphereT(cl color.RGBA) {
	gl.Begin(gl.TRIANGLE_STRIP)
	for i := uint8(0); i < total; i++ {
		for j := uint8(0); j < total; j++ {
			v0 := sphere[i][j]
			v1 := sphere[i][j+1]
			v2 := sphere[i+1][j]
			v3 := sphere[i+1][j+1]
			gl.Color3f(float32(cl.R)/255, float32(cl.G)/255, float32(cl.B)/255)
			gl.Vertex3f(v0.x, v0.y, v0.z)
			gl.Vertex3f(v1.x, v1.y, v1.z)
			gl.Vertex3f(v2.x, v2.y, v2.z)
			gl.Vertex3f(v3.x, v3.y, v3.z)
		}
	}
	gl.End()
	gl.Color3f(.7, .7, .7)
	gl.Begin(gl.LINE_STRIP)
	for i := 0; i < total; i++ {
		for j := 0; j < total; j++ {
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
