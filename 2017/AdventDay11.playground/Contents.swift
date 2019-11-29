//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

let inputUrl = Bundle.main.url(forResource: "Input", withExtension: ".txt")!
let input = try String(contentsOf: inputUrl)


let directionsInput = input.components(separatedBy: ",")

let steps: [Step] = directionsInput.map {
    switch ($0) {
    case "n": return Step.North
    case "ne": return Step.NorthEast
    case "se": return Step.SouthEast
    case "s": return Step.South
    case "sw": return Step.SouthWest
    case "nw": return Step.NorthWest
    default: fatalError("Unknown")
    }
}


solution(steps)
