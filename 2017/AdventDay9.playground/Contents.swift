//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport


let inputUrl = Bundle.main.url(forResource: "AdventDay9Input", withExtension: ".txt")!
let input = try String(contentsOf: inputUrl)

var numGarbage = 0
var score = 0
var levelsDeep = 0
var ignoreNext = false
var isInGarbage = false

for character in input {
    
    if (ignoreNext) {
        ignoreNext = false
        continue
    }
    
    if (isInGarbage) { numGarbage += 1 }
    
    switch (character) {
    case "{": if (!isInGarbage) { levelsDeep += 1 }
    case "}":
        if (!isInGarbage) {
            levelsDeep -= 1
            score = score + 1 + levelsDeep
        }
    case "<": isInGarbage = true
    case ">":
        numGarbage -= 1
        isInGarbage = false
    case "!":
        numGarbage -= 1
        ignoreNext = true
    default: break
    }
}

print("Score is \(score)")
print("Num garbage is \(numGarbage)")
