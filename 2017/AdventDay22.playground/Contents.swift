//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

let inputUrl = Bundle.main.url(forResource: "Input", withExtension: ".txt")!
let input = try String(contentsOf: inputUrl)

let inputMap = input.components(separatedBy: .newlines)
    .map { (string) -> [Bool] in
        return string.map { $0 == "#" }
}

let iterationsPart1 = 10000
print("Part1 \(iterationsPart1) iterations caused \(part1(iterationsPart1, inputMap: inputMap)) infections")
let iterationsPart2 = 10000000
print("Part2 \(iterationsPart2) iterations caused \(part2(iterationsPart2, inputMap: inputMap)) infections")
