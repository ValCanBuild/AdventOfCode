//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

let inputUrl = Bundle.main.url(forResource: "Input", withExtension: ".txt")!
let input = try String(contentsOf: inputUrl)

let moves: [Move] = inputToMoves(input: input)
let programsSimple = ["a", "b", "c", "d", "e"]
let programs = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p"]

func part1() {
    let result = movesToResult(startPrograms: programs, moves: moves)
    print(result.joined())
}

func part2() {
    let result = movesToResult(startPrograms: programs, moves: moves, numTimes: 19600)
    print(result.joined())
}

part1()
part2()
