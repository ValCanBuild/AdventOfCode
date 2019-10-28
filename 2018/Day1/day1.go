package main

import (
    "fmt"
	"utils"
	"strconv"
)

func main() {
	lines := utils.ReadFileAsStringLines("input.txt")

	frequencies := []int{}

	for _, line := range lines {
		number, err := strconv.Atoi(line)
		utils.Check(err)
		frequencies = append(frequencies, number)
	}

	// part1(frequencies)
	part2(frequencies)
}

func part1(frequencies []int) {
	var sum = 0

	for _, frequency := range frequencies {
		sum += frequency
	}

	fmt.Print("Final frequency is ", sum)
}

func part2(frequencies []int) {
	var currFrequency = 0

	index := 0
	length := len(frequencies)

	seenFreqs := make(map[int]int)

	for {
		frequency := frequencies[index]
		currFrequency += frequency

		_, seen := seenFreqs[currFrequency]
		if seen {
			fmt.Print("First frequency seen twice is ", currFrequency)
			return
		} 

		seenFreqs[currFrequency] = 0

		index++
		if (index == length) {
			index = 0
		}
	}
}