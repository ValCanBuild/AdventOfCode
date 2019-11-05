package main

import (
	"fmt"
	"strings"
	"utils"
)

func main() {
	input := utils.ReadFileAsStringLines("input.txt")

	preReqs := make(map[rune][]rune)
	for _, line := range input {
		split := strings.Split(line, " ")
		prereq := []rune(split[1])[0]
		step := []rune(split[7])[0]

		preReqs[step] = append(preReqs[step], prereq)
	}

	// part1(preReqs)
	part2(preReqs)
}

func part2(preReqs map[rune][]rune) {
	availableWorkers := 5
	totalTime := 0

	steps := make([]rune, 26)

	for i := 'A'; i <= 'Z'; i++ {
		steps[i-65] = rune(i)
	}

	order := []rune{}
	activeSteps := make(map[rune]int)

	for {
		for _, step := range steps {
			dependsOn := preReqs[step]
			_, isActive := activeSteps[step]
			if !isActive && availableWorkers > 0 && len(dependsOn) == 0 {
				availableWorkers--
				activeSteps[step] = totalTime
			}
		}
		
		for step, timeStarted := range activeSteps {
			timeNeeded := 60 + (int(step) - 'A')
			timePassedSinceStarted := totalTime - timeStarted
			if timePassedSinceStarted == timeNeeded {
				order = append(order, step)

				steps = removeObject(steps, step)

				delete(activeSteps, step)

				for key, runes := range preReqs {
					contains, index := contains(runes, step)
					if contains {
						preReqs[key] = removeIndex(runes, index)
					}
				}

				availableWorkers++
			}
		}

		totalTime++

		if len(order) == 26 {
			break
		}
	}

	fmt.Println("Final order is", string(order))
	fmt.Println("Time taken:", totalTime)
}

func part1(preReqs map[rune][]rune) {
	steps := make([]rune, 26)

	for i := 65; i < 91; i++ {
		steps[i-65] = rune(i)
	}

	order := []rune{}

	for {
		for index, step := range steps {
			dependsOn := preReqs[step]
			if len(dependsOn) == 0 {
				order = append(order, step)
				steps = removeIndex(steps, index)

				for key, runes := range preReqs {
					contains, index := contains(runes, step)
					if contains {
						preReqs[key] = removeIndex(runes, index)
					}
				}

				break
			}
		}

		if len(order) == 26 {
			break
		}
	}

	fmt.Println("Final order is", string(order))
}

func removeIndex(s []rune, index int) []rune {
	return append(s[:index], s[index+1:]...)
}

func removeObject(s []rune, object rune) []rune {
	for i, a := range s {
		if a == object {
			return removeIndex(s, i)
		}
	}
	return s
}

func contains(s []rune, e rune) (bool, int) {
	for i, a := range s {
		if a == e {
			return true, i
		}
	}
	return false, -1
}
