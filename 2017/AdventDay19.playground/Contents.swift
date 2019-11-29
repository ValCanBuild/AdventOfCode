//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

let inputUrl = Bundle.main.url(forResource: "Input", withExtension: ".txt")!
let input = try String(contentsOf: inputUrl)

func solution() -> (String, Int) {

    let puzzle = inputToPuzzle(input)
    
    var letters: [String] = []
    var currentLetter = ""
    var row = 0
    var column = 0

    for (i, puzzLine) in puzzle.enumerated() {
        for (j, part) in puzzLine.enumerated() {
            if (part == "|") {
                currentLetter = part
                column = j
                break
            }
        }

        if (currentLetter == "|") {
            row = i
            break
        }
    }


    var goingDown = true
    var goingRight = true
    var movingVertically = true
    var numSteps = 0

    while (true) {

        numSteps += 1

        switch (currentLetter) {
        case "|", "-":
            if (movingVertically) {
                row += goingDown ? 1 : -1
            } else {
                column += goingRight ? 1 : -1
            }
        case "+":
            if (movingVertically) {
                let leftColumn = column-1
                let rightColumn = column+1
                if (leftColumn >= 0 && puzzle[row][leftColumn] != " ") {
                    column = leftColumn
                    goingRight = false
                } else if (rightColumn < puzzle[row].count && puzzle[row][rightColumn] != " ") {
                    column = rightColumn
                    goingRight = true
                } else {
                    fatalError("Unknown column")
                }
            } else {
                let upRow = row-1
                let downRow = row+1
                if (upRow >= 0 && puzzle[upRow][column] != " ") {
                    row = upRow
                    goingDown = false
                } else if (downRow < puzzle.count && puzzle[downRow][column] != " ") {
                    row = downRow
                    goingDown = true
                } else {
                    fatalError("Unknown row")
                }
            }
            movingVertically = !movingVertically
        default:
            letters.append(currentLetter)
            if (movingVertically) {
                row += goingDown ? 1 : -1
            } else {
                column += goingRight ? 1 : -1
            }
        }

        if (row < 0 || column < 0 || row >= puzzle.count || column >= puzzle[row].count) {
            break
        }

        currentLetter = puzzle[row][column]

        if (currentLetter == " ") {
            break
        }
    }

    return (letters.joined(), numSteps)
}

print(solution())
