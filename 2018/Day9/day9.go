package main

import (
	"utils"
	"fmt"
	"time"
	"container/list"
)
func main() {

	numPlayers := 431
	lastMarble := 70950

	slowSolver(numPlayers, lastMarble)
	fastSolver(numPlayers, lastMarble)
}

func fastSolver(numPlayers, lastMarble int) {
	defer utils.TimeTrack(time.Now(), "fastSolver") 
	playerPoints := make(map[int]int)

	marbles := list.New()
	currentMarble := -1
	var activeMarbleElement *list.Element 

	playerTurn := -1

	for currentMarble < lastMarble {
		currentMarble++
		playerTurn++

		if currentMarble == 0 {
			activeMarbleElement = marbles.PushBack(currentMarble)
		} else if currentMarble % 23 == 0 {
			playerPoints[playerTurn] += currentMarble
			additionalMarbleElement := activeMarbleElement

			for i := 0; i < 7; i++ {
				additionalMarbleElement = additionalMarbleElement.Prev()
				if additionalMarbleElement == nil {
					additionalMarbleElement = marbles.Back()
				}
			} 
			
			activeMarbleElement = additionalMarbleElement.Next()
			additionalMarbleValue := additionalMarbleElement.Value.(int)
			playerPoints[playerTurn] += additionalMarbleValue
			marbles.Remove(additionalMarbleElement)
		} else {
			nextMarblePlace := activeMarbleElement.Next()
			if nextMarblePlace == nil {
				activeMarbleElement = marbles.InsertAfter(currentMarble, marbles.Front())
			} else {
				activeMarbleElement = marbles.InsertAfter(currentMarble, nextMarblePlace)
			}
		}

		if playerTurn == numPlayers - 1 {
			playerTurn = -1
		}
	}

	highScore := 0
	for _, score := range playerPoints {
		if score > highScore {
			highScore = score
		}
	}

	fmt.Println("highest score is", highScore)
}

func slowSolver(numPlayers, lastMarble int) {
	defer utils.TimeTrack(time.Now(), "slowSolver") 
	playerPoints := make(map[int]int)

	marbles := []int{}
	currentMarble := -1
	activeMarbleIndex := -1

	playerTurn := -1

	for currentMarble < lastMarble {
		currentMarble++
		playerTurn++

		if currentMarble == 0 {
			marbles = append(marbles, currentMarble)
			activeMarbleIndex = 0
		} else if currentMarble % 23 == 0 {
			playerPoints[playerTurn] += currentMarble
			additionalMarbleIndex := activeMarbleIndex - 7
			if additionalMarbleIndex < 0 {
				additionalMarbleIndex = len(marbles) + additionalMarbleIndex
			}
			playerPoints[playerTurn] += marbles[additionalMarbleIndex]
			marbles = removeIndex(marbles, additionalMarbleIndex)

			activeMarbleIndex = additionalMarbleIndex

		} else {
			nextMarblePlace := activeMarbleIndex + 2
			numMarbles := len(marbles)
			if nextMarblePlace > numMarbles {
				nextMarblePlace = nextMarblePlace - numMarbles
			}

			marbles = insertAtIndex(marbles, nextMarblePlace, currentMarble)

			activeMarbleIndex = nextMarblePlace
		}

		// for i, m := range marbles {
		// 	if i == activeMarbleIndex {
		// 		fmt.Printf("(%d) ", m)
		// 	} else {
		// 		fmt.Printf("%d ", m)
		// 	}
		// }
		// fmt.Println()

		if playerTurn == numPlayers - 1 {
			playerTurn = -1
		}
	}

	highScore := 0
	for _, score := range playerPoints {
		if score > highScore {
			highScore = score
		}
	}

	fmt.Println("highest score is", highScore)
}

func removeIndex(s []int, index int) []int {
	return append(s[:index], s[index+1:]...)
}

func insertAtIndex(s []int, index int, value int) []int {
	newArr := append(s, 0)
	copy(newArr[index+1:], newArr[index:])
	newArr[index] = value

	return newArr
}

func indexOf(s []int, item int) int {
	for index, value := range s {
		if item == value {
			return index
		}
	}

	panic("Array does not contain item")
}
