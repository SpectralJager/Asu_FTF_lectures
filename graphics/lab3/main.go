package main

import (
	"runtime"
	"time"

	"github.com/go-gl/gl/v4.6-core/gl"
	"github.com/go-gl/glfw/v3.2/glfw"
)

const (
	width   = 500
	height  = 500
	rows    = 100
	columns = 100
)

var (
	square = []float32{
		-.5, .5, 0,
		-.5, -.5, 0,
		.5, -.5, 0,

		-.5, .5, 0,
		.5, .5, 0,
		.5, -.5, 0,
	}
)

func draw(window *glfw.Window, program uint32) error {
	vao := makeVao(square)
	gl.BindVertexArray(vao)
	gl.DrawArrays(gl.TRIANGLES, 0, int32(len(square)/3))
	return nil
}

func main() {
	runtime.LockOSThread()
	defer runtime.UnlockOSThread()

	window := initGlfw()
	defer glfw.Terminate()

	program := initGL()

	window.SetKeyCallback(func(w *glfw.Window, key glfw.Key, scancode int, action glfw.Action, mods glfw.ModifierKey) {
		if key == glfw.KeyEscape && action == glfw.Press {
			window.SetShouldClose(true)
		}
	})

	for !window.ShouldClose() {
		gl.Clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT)
		gl.UseProgram(program)
		draw(window, program)
		glfw.PollEvents()
		window.SwapBuffers()
		time.Sleep(time.Second / 24)
	}
}
