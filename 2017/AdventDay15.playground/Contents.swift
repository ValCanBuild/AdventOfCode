//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

let inputSimpleA = 65
let inputSimpleB = 8921

let inputA = 512
let inputB = 191

let generatorA = Generator(input: inputA, factor: 16807)
let generatorB = Generator(input: inputB, factor: 48271)

print("Num matching pairs Part 1 is \(findPairsPart1(generatorA, generatorB, 50000000))")
print("Num matching pairs Part 2 is \(findPairsPart2(generatorA, generatorB, 5000000))")
