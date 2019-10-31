package main

import (
	"fmt"
	"utils"
	"unicode"
	"strings"
	"time"
)

func main() {
	polymer := utils.ReadFileAsString("input.txt")

	polymer = part1(polymer)
	part2(polymer)
}

func part1(polymer string) string {
	defer utils.TimeTrack(time.Now(), "part1")
	finalPolymer := reactPolymer(polymer)

	fmt.Println("Final polymer length is", len(finalPolymer))

	return finalPolymer
}

func part2(polymer string) {
	defer utils.TimeTrack(time.Now(), "part1")
	shortestLength := utils.MaxInt

	for i := 65; i <= 90; i++ {
		upperChar := rune(i)
		lowerChar := unicode.ToLower(upperChar)

		newPolymer := strings.ReplaceAll(polymer, string(upperChar), "")
		newPolymer = strings.ReplaceAll(newPolymer, string(lowerChar), "")

		reactedPolymer := reactPolymer(newPolymer)
		length := len(reactedPolymer)
		if length < shortestLength {
			shortestLength = length
		}
	 }
	 
	 fmt.Println("Shortest polymer length is", shortestLength)
}

func reactPolymer(polymer string) string {
	for {
		newPolymer := polymer

		for i := len(newPolymer) - 1; i >= 0; i-- {
			if i == len(newPolymer) - 1 {
				continue
			}

			char := rune(newPolymer[i])
			prevChar := rune(newPolymer[i+1])

			canReact := char != prevChar && unicode.ToLower(char) == unicode.ToLower(prevChar)
			if canReact {
				newPolyStart := newPolymer[:i]
				newPolyEnd := newPolymer[i+2:]
				newPolymer = newPolyStart + newPolyEnd
			}
		}

		polymer = newPolymer

		if len(newPolymer) == len(polymer) {
			break
		}
	}

	return polymer
}