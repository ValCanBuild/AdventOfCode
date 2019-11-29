//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

let inputUrl = Bundle.main.url(forResource: "Input", withExtension: ".txt")!
let input = try String(contentsOf: inputUrl)

let instructions = input.components(separatedBy: .newlines)

print("Num times mul called \(part1(instructions: instructions))")
print("Value in h is \(part2Optimised())")
