//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

let inputUrl = Bundle.main.url(forResource: "Input", withExtension: ".txt")!
let input = try String(contentsOf: inputUrl)

let layersArray: [Layer] = input
    .components(separatedBy: .newlines)
    .map {
        let split = $0.components(separatedBy: ": ")
        return Layer(depth: Int(split[0])!, range: Int(split[1])!)
}

var layersDict: [Int : Layer] = [:]
for layer in layersArray {
    layersDict[layer.depth] = layer
}

let maxDepth = layersArray.last!.depth
print("Severity of trip is \(calculateSeverityOfTrip(layers: layersDict, maxDepth: maxDepth).0)")
print("Delay is \(calculateNumSkipsToPass(layers: layersDict, maxDepth: maxDepth))")
