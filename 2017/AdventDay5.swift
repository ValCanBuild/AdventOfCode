//: Playground - noun: a place where people can play

import Foundation
import PlaygroundSupport

let inputUrl = Bundle.main.url(forResource: "AdventDay5Input", withExtension: ".txt")!
let input = try String(contentsOf: inputUrl)
let lines = input.components(separatedBy: .newlines)


func part1() -> Int {
    var instructions = lines.map { Int($0)! }
    
    var numSteps = 0
    var index = 0
    
    while (index >= 0 && index < instructions.count) {
        let nextIndex = index + instructions[index]
        instructions[index] += 1
        index = nextIndex
        
        numSteps += 1
    }
    
    return numSteps
}

func part2() -> UInt {
    var instructions = lines.map { Int($0)! }
    
    var numSteps: UInt = 0
    var index = 0
    
    while (index >= 0 && index < instructions.count) {
        let offset = instructions[index]
        let nextIndex = index + offset
        
        let indexChange = offset >= 3 ? -1 : 1
        instructions[index] += indexChange
        index = nextIndex
        
        numSteps += 1
    }
    
    return numSteps
}


//print("Part 1 exit found in \(part1()) steps")
print("Part 2 exit found in \(part2()) steps")

