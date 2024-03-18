package main

import (
	"bytes"
	"crypto/md5"
	"errors"
	"fmt"
	"image"
	"image/color"
	"image/png"
	"os"
)

var message = "Прежде всего, повышение уровня гражданского сознания, а также свежий взгляд на привычные вещи - безусловно открывает новые горизонты для системы массового участия. Для современного мира понимание сути ресурсосберегающих технологий позволяет оценить значение поэтапного и последовательного развития общества. В частности, социально-экономическое развитие однозначно определяет каждого участника как способного принимать собственные решения касаемо форм воздействия."

func main() {
	fmt.Printf("Origin message:  {%s}\n", message)
	err := Encoder(message, "lab6.png", "out.png")
	if err != nil {
		panic(err)
	}

	fmt.Println()

	msg, err := Decode("out.png")
	if err != nil {
		panic(err)
	}

	fmt.Printf("Decoded message: {%s}\n", msg)

	fmt.Println()

	fmt.Println("Hashes |>")
	fmt.Printf("origin:  0x%x\nencoded: 0x%x\n", HashFile("lab6.png"), HashFile("out.png"))
}

func HashFile(filePath string) []byte {
	data, err := os.ReadFile(filePath)
	if err != nil {
		return make([]byte, 0)
	}

	res := md5.Sum(data)

	return res[:]
}

func Decode(inputPath string) (string, error) {
	inputFile, err := os.Open(inputPath)
	if err != nil {
		return "", err
	}
	defer inputFile.Close()

	img, err := png.Decode(inputFile)
	if err != nil {
		return "", err
	}

	strBuf := bytes.NewBufferString("")

	err = WalkImage(img, func(x, y int) error {
		var symb uint32

		r, g, b, _ := img.At(x, y).RGBA()

		symb |= b & 0x000f
		symb <<= 4
		symb |= g & 0x000f
		symb <<= 4
		symb |= r & 0x000f

		// if symb != 0 {
		// 	fmt.Printf("decoded: %s == %04x  {%02x; %02x; %02x}\n", string(rune(symb)), symb, uint8(r), uint8(g), uint8(b))
		// }

		strBuf.WriteRune(rune(symb))

		return nil
	})

	return strBuf.String(), err
}

func Encoder(msg, inputPath, outPath string) error {
	inputFile, err := os.Open(inputPath)
	if err != nil {
		return err
	}
	defer inputFile.Close()

	srcImg, err := png.Decode(inputFile)
	if err != nil {
		return err
	}

	bounds := srcImg.Bounds()

	dstImg := image.NewNRGBA(image.Rect(0, 0, bounds.Max.X, bounds.Max.Y))

	if bounds.Max.X*bounds.Max.Y <= len(msg) {
		return errors.New("message size >= image bounds")
	}

	strBuf := bytes.NewBufferString(msg)

	err = WalkImage(srcImg, func(x, y int) error {
		var newR, newG, newB uint8

		r, g, b, a := srcImg.At(x, y).RGBA()

		newR = uint8(r) & 0xf0
		newG = uint8(g) & 0xf0
		newB = uint8(b) & 0xf0

		if rn, _, err := strBuf.ReadRune(); err == nil {
			newR |= uint8(rn & 0x000f)
			newG |= uint8(rn & 0x00f0 >> 4)
			newB |= uint8(rn & 0x0f00 >> 8)
			// fmt.Printf("encoded: %s == %04x  {%02x <> %02x; %02x <> %02x; %02x <> %02x}\n", string(rn), rn, uint8(r), newR, uint8(g), newG, uint8(b), newB)
		}

		dstImg.SetNRGBA(x, y, color.NRGBA{
			R: newR,
			G: newG,
			B: newB,
			A: uint8(a),
		})

		return nil
	})
	if err != nil {
		return err
	}

	outFile, err := os.Create(outPath)
	if err != nil {
		return err
	}
	defer outFile.Close()

	err = png.Encode(outFile, dstImg)
	if err != nil {
		return err
	}
	return nil
}

func WalkImage(img image.Image, mapper func(x, y int) error) error {
	for y := img.Bounds().Min.Y; y < img.Bounds().Max.Y; y++ {
		for x := img.Bounds().Min.X; x < img.Bounds().Max.X; x++ {
			err := mapper(x, y)
			if err != nil {
				return err
			}
		}
	}
	return nil
}
