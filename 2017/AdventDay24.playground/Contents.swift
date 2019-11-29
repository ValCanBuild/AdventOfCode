//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

let inputUrl = Bundle.main.url(forResource: "Input", withExtension: ".txt")!
let input = try String(contentsOf: inputUrl)

let sol = solution(input)
print("Max strength is \(sol.0) and max longest strength is \(sol.1)")
