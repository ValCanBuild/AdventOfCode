//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

let inputUrl = Bundle.main.url(forResource: "Input", withExtension: ".txt")!
let input = try String(contentsOf: inputUrl)

let startingGrid: Grid = [
    [".", "#", "."],
    [".", ".", "#"],
    ["#", "#", "#"]
]

let rules = inputToGridRules(input)
let numIterations = 18

print("Pixels on after \(numIterations) iterations is \(numPixelsAfterIterations(startingGrid: startingGrid, rules: rules, numIterations: numIterations))")

