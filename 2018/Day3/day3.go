package main

import (
    "fmt"
	"utils"
	"strconv"
	"strings"
)

type claim struct {
	id string
	x int
	y int
	width int
	height int
	right int
	bottom int
}

func (c *claim) overlappedArea(other *claim) int {
	xOverlap := utils.Max(0, utils.Min(c.right, other.right) - utils.Max(c.x, other.x))
	yOverlap := utils.Max(0, utils.Min(c.bottom, other.bottom) - utils.Max(c.y, other.y))

	return xOverlap * yOverlap
} 

func main() {
	lines := utils.ReadFileAsStringLines("input.txt")

	claims := []claim{}

	for _, line := range lines {
		parts := strings.Split(line, " ")
		id := parts[0]
		coords := strings.Split(strings.Replace(parts[2], ":", "", -1), ",")
		x, err := strconv.Atoi(coords[0])
		utils.Check(err)
		y, err := strconv.Atoi(coords[1])
		utils.Check(err)

		size := strings.Split(parts[3], "x")
		width, err := strconv.Atoi(size[0])
		utils.Check(err)
		height, err := strconv.Atoi(size[1])
		utils.Check(err)

		c := claim{id: id, x: x, y: y, width: width, height: height, right: x + width, bottom: y + height}
		claims = append(claims, c)
	}

	part1(claims)
	part2(claims)
}

func part1(claims []claim) {
	areaArr := [1000][1000]int{}

	totalOverlap := 0

	for _, c := range claims {
		for x := c.x; x < c.right; x++ {
			for y := c.y; y < c.bottom; y++ {
				areaArr[x][y]++
				if (areaArr[x][y] == 2) {
					totalOverlap++
				}
			}
		}
	}

	fmt.Println("Total overlap is", totalOverlap)
 }

 func part2(claims []claim) {
	for _, claimA := range claims {
		overlapArea := 0
		for _, claimB := range claims {
			if claimA == claimB {
				continue
			}
			overlapArea += claimA.overlappedArea(&claimB)
		}

		if overlapArea == 0 {
			fmt.Println("Claim which doesn't overlap is", claimA)
			break
		}
	}
 }