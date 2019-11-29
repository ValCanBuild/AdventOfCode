//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

let inputUrl = Bundle.main.url(forResource: "Input", withExtension: ".txt")!
let input = try String(contentsOf: inputUrl)

let instructions = input.components(separatedBy: .newlines)

print("Last sound recovered is \(part1(instructions: instructions))")
part2(instructions: instructions)
