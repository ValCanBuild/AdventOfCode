//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

let inputUrl = Bundle.main.url(forResource: "InputSimple", withExtension: ".txt")!
let input = try String(contentsOf: inputUrl)
