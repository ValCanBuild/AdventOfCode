import Foundation

public func inputToPuzzle(_ input: String) -> [[String]] {
    var puzzle: [[String]] = []

    let lines = input.components(separatedBy: .newlines)
    for line in lines {
        var puzzleLine: [String] = []
        for i in 0..<line.count {
            puzzleLine.append(String(line[line.index(line.startIndex, offsetBy: i)]))
        }

        puzzle.append(puzzleLine)
    }

    return puzzle
}

