//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

// need a map of registers
// need an instruction parser

typealias Register = String

enum Operation {
    case Increment(Int)
    case Decrement(Int)
}

enum Check {
    case MoreOrEqual(Int)
    case More(Int)
    case Equal(Int)
    case NotEqual(Int)
    case Less(Int)
    case LessOrEqual(Int)
}

struct Instruction {
    let operation: Operation
    let check: Check
    let targetRegister: Register
    let checkRegister: Register
}

func inputToInstructions(input: String) -> [Instruction] {
    let lines = input.components(separatedBy: .newlines)
    
    return lines.map {
        let parts = $0.components(separatedBy: " ")
        let targetRegister: Register = parts[0]
        
        let opAmount = Int(parts[2])!
        let operation: Operation = parts[1] == "inc" ? .Increment(opAmount) : .Decrement(opAmount)
        
        let checkRegister: Register = parts[4]
        
        let checkAmount = Int(parts[6])!
        let check: Check = convertStringToCheck(parts[5], amount: checkAmount)
        
        return Instruction(operation: operation, check: check, targetRegister: targetRegister, checkRegister: checkRegister)
    }
}

func convertStringToCheck(_ string: String, amount: Int) -> Check {
    switch (string) {
    case ">": return .More(amount)
    case ">=": return .MoreOrEqual(amount)
    case "==": return .Equal(amount)
    case "!=": return .NotEqual(amount)
    case "<=": return .LessOrEqual(amount)
    case "<": return .Less(amount)
    default: fatalError("Unrecognized check type")
    }
}

let inputUrl = Bundle.main.url(forResource: "AdventDay8Input", withExtension: ".txt")!
let input = try String(contentsOf: inputUrl)

func solution() -> (Int, Int) {
    let instructions = inputToInstructions(input: input)
    
    var registerValueDict: [String : Int] = [:]
    var highestValueEver = 0
    
    for instruction in instructions {
        let targetRegValue = registerValueDict[instruction.targetRegister] ?? 0
        let checkRegValue = registerValueDict[instruction.checkRegister] ?? 0
        
        var doOperation = false
        
        switch (instruction.check) {
        case .More(let amount): doOperation = checkRegValue > amount
        case .MoreOrEqual(let amount): doOperation = checkRegValue >= amount
        case .Equal(let amount): doOperation = checkRegValue == amount
        case .NotEqual(let amount): doOperation = checkRegValue != amount
        case .LessOrEqual(let amount): doOperation = checkRegValue <= amount
        case .Less(let amount): doOperation = checkRegValue < amount
        }
        
        var newAmount = targetRegValue
        
        if (doOperation) {
            switch (instruction.operation) {
            case .Increment(let amount): newAmount = targetRegValue + amount
            case .Decrement(let amount): newAmount = targetRegValue - amount
            }
        }
        
        registerValueDict[instruction.targetRegister] = newAmount
        highestValueEver = max(highestValueEver, newAmount)
    }
    
    let largestValue = registerValueDict.values.max()!
    
    return (registerValueDict.values.max()!, highestValueEver)
}

let answer = solution()

print("Largest value in any register at the end is \(answer.0)")
print("Highest value in any register during process is \(answer.1)")
