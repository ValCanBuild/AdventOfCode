package main

import (
    "fmt"
	"utils"
	"sort"
	"time"
	"strings"
	"strconv"
)

func main() {
	lines := utils.ReadFileAsStringLines("input.txt")
	sort.Strings(lines)

	part1(lines)
	fmt.Println()
	part2(lines)
}

func part1(lines []string) {
	guardSleepTimes := make(map[int]time.Duration)
	activeGuardID := 0
	var activeGuardAsleepTime time.Time

	guardSleepMinutes := make(map[int][]int)

	for _, line := range lines {
		dateStart := strings.Index(line, "]")
		dateText := line[1:dateStart]
		date, err := time.Parse("2006-01-02 15:04", dateText)
		utils.Check(err)

		pieces := strings.Fields(line[dateStart+2:])
		switch pieces[0] {
		case "Guard":
			id, err := strconv.Atoi(pieces[1][1:])
			activeGuardID = id
			utils.Check(err)
		case "falls":
			activeGuardAsleepTime = date
		case "wakes":
			sleepTime := date.Sub(activeGuardAsleepTime)
			guardSleepTimes[activeGuardID] += sleepTime

			_, seen := guardSleepMinutes[activeGuardID]
			if !seen {
				guardSleepMinutes[activeGuardID] = make([]int, 60)
			}

			for i := activeGuardAsleepTime.Minute(); i < date.Minute(); i++ {
				guardSleepMinutes[activeGuardID][i]++
			}
		}
	} 

	sleepiestGuardID := 0
	var maxSleepTime time.Duration
	for key, value := range guardSleepTimes {
		if value > maxSleepTime {
			maxSleepTime = value
			sleepiestGuardID = key
		}
	}

	sleepiestMinute, _ := utils.MaxArg(guardSleepMinutes[sleepiestGuardID]...)

	fmt.Printf("Sleepiest guard is %d. His sleepiest minute was %d", sleepiestGuardID, sleepiestMinute)
}

func part2(lines []string) {
	guardSleepTimes := make(map[int]time.Duration)
	activeGuardID := 0
	var activeGuardAsleepTime time.Time

	guardSleepMinutes := make(map[int][]int)

	for _, line := range lines {
		dateStart := strings.Index(line, "]")
		dateText := line[1:dateStart]
		date, err := time.Parse("2006-01-02 15:04", dateText)
		utils.Check(err)

		pieces := strings.Fields(line[dateStart+2:])
		switch pieces[0] {
		case "Guard":
			id, err := strconv.Atoi(pieces[1][1:])
			activeGuardID = id
			utils.Check(err)
		case "falls":
			activeGuardAsleepTime = date
		case "wakes":
			sleepTime := date.Sub(activeGuardAsleepTime)
			guardSleepTimes[activeGuardID] += sleepTime

			_, seen := guardSleepMinutes[activeGuardID]
			if !seen {
				guardSleepMinutes[activeGuardID] = make([]int, 60)
			}

			for i := activeGuardAsleepTime.Minute(); i < date.Minute(); i++ {
				guardSleepMinutes[activeGuardID][i]++
			}
		}
	} 

	minuteMap := make(map[int]int)

	minuteWithMostSleep := 0
	mostSleepMinute := 0

	for m := 0; m < 60; m++ {
		guardThatSleptMostThisMinute := 0
		mostSleepThisMinute := 0
		for guardID, minutes := range guardSleepMinutes {
			if minutes[m] > mostSleepThisMinute {
				mostSleepThisMinute = minutes[m]
				guardThatSleptMostThisMinute = guardID
			}
		}

		if mostSleepThisMinute > mostSleepMinute {
			mostSleepMinute = mostSleepThisMinute
			minuteWithMostSleep = m
		}

		minuteMap[m] = guardThatSleptMostThisMinute
	}

	fmt.Printf("Minute with most sleep was %d. Guard that slept most that minute was %d", minuteWithMostSleep, minuteMap[minuteWithMostSleep])
}