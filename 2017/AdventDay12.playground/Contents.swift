//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

let inputUrl = Bundle.main.url(forResource: "Input", withExtension: ".txt")!
let input = try String(contentsOf: inputUrl)

let allPrograms: [Program] = input
    .components(separatedBy: .newlines)
    .map {
        let parts = $0.components(separatedBy: " <-> ")
        let id = Int(parts[0])!
        let otherParts = parts[1].components(separatedBy: ", ")
        let connectedIds = otherParts.map { Int($0)! }

        return Program(id: id, connectedIds: connectedIds)
}

let targetProgram = allPrograms[0]
let connectedIdSetToZero = findAllProgramsConnectedToProgram(targetProgram, inAllPrograms: allPrograms)

print("Num connected programs is \(connectedIdSetToZero.count)")

let allIds = allPrograms.map { $0.id }
let numGroups = findNumGroupsInSetOfAllPrograms(allProgramsIdSet: Set(allIds), allPrograms: allPrograms)

print("Num program groups is \(numGroups)")
