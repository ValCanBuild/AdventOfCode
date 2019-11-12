package main

import (
	"fmt"
	"utils"
)

type note struct {
	pattern string
	produce rune
}

func main() {
	input := utils.ReadFileAsStringLines("input.txt")

	var initialState string 
	fmt.Sscanf(input[0], "initial state: %s", &initialState)

	notes := make([]note, len(input) - 2)
	for i := 2; i < len(input); i++ {
		var pattern string
		var produce rune
		fmt.Sscanf(input[i], "%s => %c", &pattern, &produce)
		notes[i - 2] = note{pattern, produce}
	}

	// part1(initialState, notes)
	part2(initialState, notes)
}

func part2(initialState string, notes []note) {
	numGenerations := 50000000000
	fmt.Println("Initial state length", len(initialState))

	numPots := len(initialState) * 70
	pots := make([]rune, numPots)

	for i := range pots {
		pots[i] = '.'
	}

	startingPotIndex := 20
	for i := 0; i < len(initialState); i++ {
		pots[startingPotIndex + i] = rune(initialState[i])
	}
	
	lastScore := -1
	lastDifference := -1

	for iter := 0; iter < numGenerations; iter++ {
		newPots := make([]rune, numPots)
		copy(newPots, pots)
		
		for i := range pots {
			// easy hack to skip checking starting and ending buffer pots
			if i < 2 || i >= numPots - 3 {
				continue
			}

			matched := false

			for _, note := range notes {
				potsToMatch := string(pots[i-2:i+3])
				if potsToMatch == note.pattern {
					newPots[i] = note.produce
					matched = true
					break
				}
			}

			if !matched {
				newPots[i] = '.'
			}
		}

		pots = newPots

		score := scorePots(pots, startingPotIndex)
		if lastScore != -1 {
			difference := score - lastScore
			if lastDifference == difference {
				finalScore := score + ((numGenerations - iter - 1) * difference)
				fmt.Printf("Same difference %d reached in iteration %d. Final score is %d", difference, iter, finalScore)
				fmt.Println()
				break
			}
			lastDifference = difference
		}

		lastScore = score
	}
}

func scorePots(pots []rune, startingPotIndex int) int {
	pointTotal := 0

	for i, pot := range pots {
		if pot == '#' {
			potIndex := i - startingPotIndex
			pointTotal += potIndex
		}
	}

	return pointTotal
}

func part1(initialState string, notes []note) {
	numGenerations := 20
	fmt.Println("Initial state length", len(initialState))

	numPots := len(initialState) * 3
	pots := make([]rune, numPots)

	for i := range pots {
		pots[i] = '.'
	}

	startingPotIndex := 4
	for i := 0; i < len(initialState); i++ {
		pots[startingPotIndex + i] = rune(initialState[i])
	}

	fmt.Println(string(pots))
	
	for iter := 0; iter < numGenerations; iter++ {
		newPots := make([]rune, numPots)
		copy(newPots, pots)
		
	
		for i := range pots {
			// easy hack to skip checking starting and ending buffer pots
			if i < 2 || i >= numPots - 3 {
				continue
			}

			matched := false

			for _, note := range notes {
				potsToMatch := string(pots[i-2:i+3])
				if potsToMatch == note.pattern {
					newPots[i] = note.produce
					matched = true
					break
				}
			}

			if !matched {
				newPots[i] = '.'
			}
		}

		pots = newPots

		fmt.Println()
		fmt.Printf("%d: %s", iter, string(pots))
	}

	pointTotal := 0

	for i, pot := range pots {
		if pot == '#' {
			potIndex := i - startingPotIndex
			pointTotal += potIndex
		}
	}

	fmt.Println("Point total is", pointTotal)
}

func contains(s []string, item string) bool {
	for _, value := range s {
		if item == value {
			return true
		}
	}

	return false
}