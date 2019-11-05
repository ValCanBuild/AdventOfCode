package main

import (
	"fmt"
	"strconv"
	"strings"
	"utils"
)

type point struct {
	x, y int
}

func (p *point) distanceTo(other *point) int {
	return utils.Abs(p.x - other.x) + utils.Abs(p.y - other.y)
}

func main() {
	input := utils.ReadFileAsStringLines("input.txt")

	points := make([]point, len(input))

	maxX := 0
	maxY := 0
	minX := utils.MaxInt
	minY := utils.MaxInt

	for i, line := range input {
		parts := strings.Split(line, ", ")
		x, err := strconv.Atoi(parts[0])
		utils.Check(err)
		y, err := strconv.Atoi(parts[1])
		utils.Check(err)

		points[i] = point{x, y}

		if x > maxX {
			maxX = x
		}

		if y > maxY {
			maxY = y
		}

		if x < minX {
			minX = x
		}

		if y < minY {
			minY = y
		}
	}

	part1(points, minY, minX, maxY, maxX)
	part2(points, minY, minX, maxY, maxX)
}

func part2(points []point, minY, minX, maxY, maxX int) {
	maxDistance := 10000

	markedArea := make([][]int, maxX - minX + 1)
	for i := range markedArea {
		markedArea[i] = make([]int, maxY - minY + 1)
	}

	for x := minX; x <= maxX; x++ {
		for y := minY; y <= maxY; y++ {
			thisPoint := point{x, y}

			combinedDistance := 0

			for _, point := range points {
				combinedDistance += thisPoint.distanceTo(&point)
			}

			if combinedDistance < maxDistance {
				markedArea[x-minX][y-minY] = 1
			} else {
				markedArea[x-minX][y-minY] = 0
			}
		}
	}

	areaSize := 0

	for x := minX; x <= maxX; x++ {
		for y := minY; y <= maxY; y++ {
			mark := markedArea[x-minX][y-minY]
			if mark == 1 {
				areaSize++
			}
		}
	}

	fmt.Println("Area size is", areaSize)
}

func part1(points []point, minY, minX, maxY, maxX int) {
	fmt.Println("Total max area has size", maxX, maxY)

	areaOwners := make([][]int, maxX - minX + 1)
	for i := range areaOwners {
		areaOwners[i] = make([]int, maxY - minY + 1)
	}

	for x := minX; x <= maxX; x++ {
		for y := minY; y <= maxY; y++ {
			thisPoint := point{x, y}

			closestDistance := utils.MaxInt
			distances := make([]int, len(points))

			for index, point := range points {
				distance := thisPoint.distanceTo(&point)
				distances[index] = distance

				if distance < closestDistance {
					closestDistance = distance
				}
			}

			closestPointIndex := -1
			closestPointFound := false

			for i, distance := range distances {
				if distance == closestDistance {
					if closestPointFound {
						closestPointIndex = -1
						break
					} else {
						closestPointIndex = i
						closestPointFound = true
					}
				}
			}

			areaOwners[x-minX][y-minY] = closestPointIndex
		}
	}

	enclosedAreaSizes := make(map[int]int)

	for index := 0; index < len(points); index++ {
		isEnclosed := false
		for x := minX; x <= maxX; x++ {
			for y := minY; y <= maxY; y++ {
				areaOwner := areaOwners[x-minX][y-minY]

				if areaOwner == index {
					if x == minX || y == minY || x == maxX || y == maxY {
						isEnclosed = true
					} else {
						enclosedAreaSizes[index]++
					}
				}

				if isEnclosed {
					break
				}
			}
			if isEnclosed {
				break
			}
		}

		if isEnclosed {
			enclosedAreaSizes[index] = 0
			continue
		}
	}

	largestEnclosedSize := 0
	for _, value := range enclosedAreaSizes {
		if value > largestEnclosedSize {
			largestEnclosedSize = value
		}
	}

	fmt.Println("largest enclosed area is", largestEnclosedSize)
}
