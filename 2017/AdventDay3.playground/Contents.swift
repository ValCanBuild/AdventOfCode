//: Playground - noun: a place where people can play

import UIKit
import Foundation

let input = 277678

func day1() {
    var nearestOddSquare = 0
    
    for i in stride(from: 3, to: input, by: 2) {
        let square = i*i
        if (square > input) {
            nearestOddSquare = i
            break
        }
    }

    print(nearestOddSquare)
    print(nearestOddSquare * nearestOddSquare)

    let nearestSquaredDistanceFromCenter = nearestOddSquare - 1
    let nearestSquaredDistance = nearestOddSquare * nearestOddSquare
    let stepsToNearestSquare = nearestSquaredDistance - input
    
    let answer = nearestSquaredDistanceFromCenter - stepsToNearestSquare
    print("Answer to part1 is \(answer)")
}

func day2() {
    enum StepType {
        case Right
        case Up
        case Left
        case Down
    }
    
    var array: [[Int]] = Array(repeatElement(Array(repeatElement(0, count: 101)), count: 101))
    
    var stepCount = 1
    var stepType = StepType.Right
    
    var x = 50
    var y = 50
    array[x][y] = 1
    
    while (true) {
        
        for i in 0..<stepCount {
            switch (stepType) {
            case .Right:
                x += 1
            case .Up:
                y += 1
            case .Left:
                x -= 1
            case .Down:
                y -= 1
            }
            
            let value = array[x+1][y] + array[x+1][y+1] + array[x][y+1] + array[x-1][y+1] + array[x-1][y] + array[x-1][y-1] + array[x][y-1] + array[x+1][y-1]
            array[x][y] = value
            
            if (value > input) {
                print("Answer to part2 is \(value)")
                return
            }
        }
        
        switch (stepType) {
        case .Right:
            stepType = .Up
        case .Up:
            stepType = .Left
            stepCount += 1
        case .Left:
            stepType = .Down
        case .Down:
            stepType = .Right
            stepCount += 1
        }
    }
}

day1()
day2()

