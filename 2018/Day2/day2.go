package main

import (
    "fmt"
	"utils"
)

func main() {
	lines := utils.ReadFileAsStringLines("input.txt")

	part1(lines)
	// part2(lines)%
}

func part1(input []string) {
	numWithTwoLetters := 0
	numWithThreeLetters := 0

	for _, line := range input {
		seenLetters := make(map[rune]int)

		for _, letter := range line {
			seenLetters[letter]++
		}

		seenTwos := false
		seenThrees := false

		for _, value := range seenLetters {
			if value == 2 && !seenTwos {
				numWithTwoLetters++
				seenTwos = true
			}
			if value == 3 && !seenThrees {
				numWithThreeLetters++
				seenThrees = true
			}
		}
	}

	checksum := numWithTwoLetters * numWithThreeLetters
	fmt.Println("Num with two letters are", numWithTwoLetters)
	fmt.Println("Num with three letters are", numWithThreeLetters)
	fmt.Println("Checksum is", checksum)
}

func part2(input []string) {
	numLines := len(input)
	for i, line := range input {
		
		for j := i+1; j < numLines; j++ {
			otherLine := input[j]

			numDiffs := 0
			diffPos := -1

			for z := 0; z < len(line); z++ {
				runeA := line[z]
				runeB := otherLine[z]

				if runeA != runeB {
					numDiffs++
					diffPos = z
				}

				if numDiffs > 1 {
					break
				}
			 }
			 
			 if numDiffs == 1 {
				fmt.Println("The matching strings are:")
				fmt.Println(line)
				fmt.Println(otherLine)
				fmt.Println("Differing position is", diffPos)
			 }
		}
	}
}