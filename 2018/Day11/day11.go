package main

import (
    "fmt"
	"strconv"
	"utils"
	"time"
)

func main() {
	gridSerialNumber := 8141

	cells := make([][]int, 300)
	for i := range cells {
		cells[i] = make([]int, 300)
	}
	
	// calculate the power levels
	for i := range cells {
		for j := range cells[i] {
			x := i + 1
			y := j + 1

			cells[i][j] = calculatePowerLevel(x, y, gridSerialNumber)

		} 
	}

	// part1(cells, gridSerialNumber)
	part2(cells, gridSerialNumber)
}

func part2(cells [][]int, gridSerialNumber int) {
	defer utils.TimeTrack(time.Now(), "Part2")

	largestPower := 0
	tarX := 0
	tarY := 0
	tarSquareSize := 0

	squareSize := 1

	for {
		squareSize++
		largestPowerForSqSize := -1

		for i := 0; i < 300 - squareSize; i++ {
			for j := 0; j < 300 - squareSize; j++ {
	
				totalPower := -1
	
				if cells[i][j] == -1 { 
					continue
				}
	
				for innerI := i; innerI < i + squareSize; innerI++ {
					for innerJ := j; innerJ < j + squareSize; innerJ++ {
						totalPower += cells[innerI][innerJ]
					}
				}
	
				if totalPower > largestPower {
					largestPower = totalPower
					tarSquareSize = squareSize
					tarX = i + 1
					tarY = j + 1
				}

				if totalPower > largestPowerForSqSize {
					largestPowerForSqSize = totalPower
				}
			}
		}

		if largestPowerForSqSize < 0 {
			break
		}
	}

	fmt.Printf("The largest square power is %d with coords at %d, %d and size %d", largestPower, tarX, tarY, tarSquareSize)
	fmt.Println()
}

func part1(cells [][]int, gridSerialNumber int) {
	defer utils.TimeTrack(time.Now(), "Part1")

	largestPower := 0
	tarX := 0
	tarY := 0

	squareSize := 3

		for i := 0; i < 300 - squareSize; i++ {
			for j := 0; j < 300 - squareSize; j++ {
	
				totalPower := 0
	
				if cells[i][j] == -1 { 
					continue
				}
	
				for innerI := i; innerI < i + squareSize; innerI++ {
					for innerJ := j; innerJ < j + squareSize; innerJ++ {
						totalPower += cells[innerI][innerJ]
					}
				}
	
				if totalPower > largestPower {
					largestPower = totalPower

					tarX = i + 1
					tarY = j + 1
				}
			}
		}

	fmt.Printf("The largest square power is %d with coords at %d, %d", largestPower, tarX, tarY)
	fmt.Println()
}


func calculatePowerLevel(x, y, gridSerialNumber int) int {
	rackID := x + 10
	powerLevel := (rackID * y) + gridSerialNumber
	powerLevel *= rackID

	str := strconv.Itoa(powerLevel)
	numLength := len(str)
	if numLength >= 3 {
		hundrethDigit := str[numLength-3:numLength-2]
		level,e := strconv.Atoi(hundrethDigit)
		utils.Check(e)

		powerLevel = level
	} else {
		powerLevel = 0
	}

	powerLevel -= 5

	return powerLevel
}