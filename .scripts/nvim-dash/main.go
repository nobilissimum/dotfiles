package main

import (
	"flag"
	"fmt"
	"os"
	"os/exec"
	"regexp"
	"strings"
)

func main() {
	homePath := os.Getenv("HOME")
	imageSrcPath := fmt.Sprintf("%v/neovim.png", homePath)
	imageCacheDirpath := fmt.Sprintf("%v/.cache", homePath)

	width := flag.Int("w", 30, "Image number of columns")
	height := flag.Int("h", 0, "Image number of row")
	flag.Parse()

	if *height == 0 {
		*height = int(float64(*width) / 2.5)
	}

	filepath := fmt.Sprintf("%v/vimdash%vx%v.txt", imageCacheDirpath, *width, *height)
	fileContent, err := os.ReadFile(filepath)
	if err == nil {
		fmt.Println(string(fileContent))
		return
	}

	rawOutput, err := exec.Command(
		"ascii-image-converter",
		"-C",
		"-c", imageSrcPath,
		"-d", fmt.Sprintf("%v,%v", *width, *height),
	).Output()
	if err != nil {
		return
	}

	output := string(rawOutput)
	outputHeight := strings.Count(output, "\n")

	ansiRegex := regexp.MustCompile(`\x1b\[[0-9;]*[mGKH]`)
	outputWidth := 0
	for _, line := range strings.Split(output, "\n") {
		visibleText := ansiRegex.ReplaceAllString(line, "")
		visibleTextLength := len(visibleText)
		if visibleTextLength > outputWidth {
			outputWidth = visibleTextLength
		}
	}

	if outputWidth != *width || outputHeight != *height {
		return
	}

	fmt.Println(output)

	outputFile, err := os.Create(filepath)
	if err != nil {
		return
	}
	defer outputFile.Close()
	outputFile.WriteString(output)
}
