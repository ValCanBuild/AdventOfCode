//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

let inputUrl = Bundle.main.url(forResource: "AdventDay4Input", withExtension: ".txt")!
let input = try String(contentsOf: inputUrl)
let lines = input.components(separatedBy: .newlines)

func findValidPhrases(_ includeAnagrams: Bool) -> Int {
    return lines.filter {
        let spaceSeparatedWords = $0.components(separatedBy: .whitespaces)
        let words = includeAnagrams ? spaceSeparatedWords.map { String($0.sorted()) } : spaceSeparatedWords
        let set = Set(words)
        return set.count == words.count
        }
        .count
}

print("Num valid for part1 is \(findValidPhrases(false))")
print("Num valid for part2 is \(findValidPhrases(true))")
