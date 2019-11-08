package main

import (
	"fmt"
	"utils"
	"strings"
)

type point struct {
	x, y int
}

type pointWithVel struct {
	coords, vel point
}

func main() {
	input := utils.ReadFileAsStringLines("input.txt")

	pointsWithVel := make([]pointWithVel, len(input))
	for i, line := range input {
		var x, y, velX, velY int
		fmt.Sscanf(strings.ReplaceAll(line, " ", ""), "position=<%d,%d>velocity=<%d,%d>", &x, &y, &velX, &velY)

		pointsWithVel[i] = pointWithVel {coords: point{x, y}, vel: point{x: velX, y: velY}}
	}
	
	part1(pointsWithVel)
}

func part1(pointsWithVel []pointWithVel) {

	// gridSize := 20000
	// grid := make([][]int, gridSize)
	// for i := 0; i < gridSize; i++ {
	// 	grid[i] = make([]int, gridSize)
	// 	for j := 0; j < gridSize; j++ {
	// 		grid[i][j] = 0
	// 	}
	// }

	gridMap := make(map[point]int)
	numSteps := 0

	for {
		numSteps++

		minY := utils.MaxInt
		maxY := 0
		minX := utils.MaxInt
		maxX := 0
		for i, point := range pointsWithVel {
			gridMap[point.coords] = utils.Max(0, gridMap[point.coords] - 1)

			point.coords.x += point.vel.x
			point.coords.y += point.vel.y

			gridMap[point.coords]++

			pointsWithVel[i] = point

			minY = utils.Min(minY, point.coords.y)
			maxY = utils.Max(maxY, point.coords.y)
			minX = utils.Min(minX, point.coords.x)
			maxX = utils.Max(maxX, point.coords.x)
		}

		unbroken := true

		for _, p := range pointsWithVel {
			coords := p.coords
			// check if there is at least 1 point around this point
			if 
			!checkPointExists(&gridMap, point{x: coords.x-1, y: coords.y}) &&
			!checkPointExists(&gridMap, point{x: coords.x-1, y: coords.y-1}) &&
			!checkPointExists(&gridMap, point{x: coords.x,   y: coords.y-1}) &&
			!checkPointExists(&gridMap, point{x: coords.x+1, y: coords.y-1}) &&
			!checkPointExists(&gridMap, point{x: coords.x+1, y: coords.y}) &&
			!checkPointExists(&gridMap, point{x: coords.x+1, y: coords.y+1}) &&
			!checkPointExists(&gridMap, point{x: coords.x,   y: coords.y+1}) && 
			!checkPointExists(&gridMap, point{x: coords.x-1, y: coords.y+1}) {
				unbroken = false
			}

			if !unbroken {
				break
			}
		}

		if unbroken && numSteps > 10 {
			fmt.Println("Reached unbroken state in steps:", numSteps)
			for j := minY-10; j <= maxY + 10; j++ {
				for i := minX-10; i <= maxX + 10; i++ {
					pointExists := checkPointExists(&gridMap, point{x: i, y: j})
					if pointExists {
						fmt.Print("#")
					} else {
						fmt.Print(".")
					}
				}
				fmt.Println()
			}
			break
		}
	}
}

func checkPointExists(pointMap *map[point]int, p point) bool {
	value, present := (*pointMap)[p]
	if present {
		return value > 0
	} 

	return false
}