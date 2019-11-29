//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

let inputUrl = Bundle.main.url(forResource: "AdventDay10Input", withExtension: ".txt")!
let input = try String(contentsOf: inputUrl)

let numElements = 256
var elementArray: [Int] = []

for i in 0..<numElements {
    elementArray.append(i)
}

func part2() {
    var values = elementArray
    let asciiValues = input.unicodeScalars.filter{$0.isASCII}.map{Int($0.value)}
    let additionalInputs: [Int] = [17, 31, 73, 47, 23]
    let lengths: [Int] = asciiValues + additionalInputs

    var skipSize = 0
    var currentPos = 0

    for _ in 0..<64 {
        let result = knotHash(values: values, lengths: lengths, startSkipSize: skipSize, startCurrentPos: currentPos)
        values = result.0
        skipSize = result.1 % 256
        currentPos = result.2 % 256
    }

    let result = values

    var denseHash: [Int] = []
    for i in 0..<16 {
        var xorResult = 0
        let startIndex = i * 16
        for j in startIndex..<startIndex + 16 {
            xorResult = xorResult ^ result[j]
        }

        denseHash.append(xorResult)
    }

    print("\(denseHash)")

    var hexString = ""
    for hashVal in denseHash {
        hexString += String(format: "%2x", hashVal)
    }

    print("Hash hex result is \(hexString)")
}

func part1() {
    let stringValues = input.components(separatedBy: ",")
    let lengths = stringValues.map { Int($0)! }

    let result = knotHash(values: elementArray, lengths: lengths, startSkipSize: 0, startCurrentPos: 0)
    let values = result.0

    let answer = values[0] * values[1]
    print("Answer is \(answer)")
}

part1()
part2()

