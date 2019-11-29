import Foundation

extension Array {

    mutating func rotateBy(_ amount: Int) {
        // Calculate the effective number of rotations
        // -> "k % length" removes the abs(k) > n edge case
        // -> "(length + k % length)" deals with the k < 0 edge case
        // -> if k > 0 the final "% length" removes the k > n edge case
        let length = self.count
        let rotations = (length + amount % length) % length

        // 1. Reverse the whole array
        let reversed: Array = self.reversed()

        // 2. Reverse first k numbers
        let leftPart: Array = reversed[0..<rotations].reversed()

        // 3. Reverse last n-k numbers
        let rightPart: Array = reversed[rotations..<length].reversed()

        self = leftPart + rightPart
    }
}

public enum Move {
    case Spin(Int)
    case Exchange(Int, Int)
    case Partner(String, String)
}

public func inputToMoves(input: String) -> [Move] {
    return input.components(separatedBy: ",")
        .map { (string) -> Move in
            let type = string[string.index(string.startIndex, offsetBy: 0)]
            if (type == "s") {
                let num = string[string.index(string.startIndex, offsetBy: 1)..<string.endIndex]
                return .Spin(Int(num)!)
            } else if (type == "x") {
                let expr = string[string.index(string.startIndex, offsetBy: 1)..<string.endIndex]
                let nums = expr.components(separatedBy: "/")
                return .Exchange(Int(nums[0])!, Int(nums[1])!)
            } else if (type == "p") {
                let expr = string[string.index(string.startIndex, offsetBy: 1)..<string.endIndex]
                let partners = expr.components(separatedBy: "/")
                return .Partner(partners[0], partners[1])
            }

            return .Exchange(0,0)
    }
}

public func movesToResult(startPrograms: [String], moves: [Move], numTimes: Int = 0) -> [String] {
    var programs = startPrograms

    for i in 0..<numTimes {
        for move in moves {
            switch (move) {
            case .Spin(let times):
                programs.rotateBy(times)
                break
            case .Exchange(let indexA, let indexB):
                programs.swapAt(indexA, indexB)
                break
            case .Partner(let partnerA, let partnerB):
                let indexA = programs.index(of: partnerA)!
                let indexB = programs.index(of: partnerB)!
                programs.swapAt(indexA, indexB)
                break
            }
        }
    }

    return programs
}
