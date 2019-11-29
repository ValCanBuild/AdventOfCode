//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport


let inputUrl = Bundle.main.url(forResource: "AdventDay7Input", withExtension: ".txt")!
let input = try String(contentsOf: inputUrl)


print("Top node is \(part1(input))")
let part2Result = part2(input)
print("Unbalanced node is \(part2Result.1) and weight needed is \(part2Result.0)")
