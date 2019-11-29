//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

let inputUrl = Bundle.main.url(forResource: "AdventDay6Input", withExtension: ".txt")!
let input = try String(contentsOf: inputUrl)
let memoryBanks = input.components(separatedBy: "    ").map { Int($0)! }

//print("Part 1 found in \(part1(memoryBanks: memoryBanks)) cycles")
print("Part 2 found in \(part2(memoryBanks: memoryBanks)) cycles")
