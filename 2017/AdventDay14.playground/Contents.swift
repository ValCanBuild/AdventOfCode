//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

let puzzleInputSimple = "flqrgnkx"
let puzzleInput = "jxqlasbh"

func countNumUsed(_ binaryArray: [String]) -> Int {
    return Int(binaryArray.map { $0.filter { $0 == "1" } }.joined().count)
}

let binaryArray = inputToBinaryStringArray(puzzleInput)
let binaryIntArray = binaryArray.map {
    $0.map { Int(String($0))! }
}

print("Num used squares is \(countNumUsed(binaryArray))")
print("Num regions is \(numRegions(binaryIntArray))")
