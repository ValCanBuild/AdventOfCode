import Foundation

public extension String {
    public var hexToBinary: String {
        get {
            return String(Int(self, radix: 16)!, radix: 2)
        }
    }
}

extension String {
    public func pad(with padding: Character, toLength length: Int) -> String {
        let paddingWidth = length - self.count
        guard 0 < paddingWidth else { return self }

        return String(repeating: padding, count: paddingWidth) + self
    }
}

func knotHashIter(values: [Int], lengths: [Int], startSkipSize: Int, startCurrentPos: Int) -> ([Int], Int, Int) {

    let numElements = values.count
    var skipSize = startSkipSize
    var currentPos = startCurrentPos
    var copyValues = values

    for length in lengths {

        var subArray: [Int] = []

        let startPos = currentPos
        let totalLength = startPos+length

        for i in startPos..<totalLength {
            let realIndex = i % numElements
            subArray.append(copyValues[realIndex])
        }

        subArray.reverse()

        for i in startPos..<totalLength {
            let realIndex = i % numElements
            let subArrayIndex = i - startPos

            copyValues[realIndex] = subArray[subArrayIndex]
        }

        currentPos += length + skipSize
        skipSize += 1
    }

    return (copyValues, skipSize, currentPos)
}

public func knotHash(values: [Int], hashInput: String) -> String {

    let asciiValues = hashInput.unicodeScalars.filter{$0.isASCII}.map{Int($0.value)}
    let additionalInputs: [Int] = [17, 31, 73, 47, 23]
    let lengths = asciiValues + additionalInputs

    var skipSize = 0
    var currentPos = 0
    var copyValues = values

    for _ in 0..<64 {
        let result = knotHashIter(values: copyValues, lengths: lengths, startSkipSize: skipSize, startCurrentPos: currentPos)
        copyValues = result.0
        skipSize = result.1 % 256
        currentPos = result.2 % 256
    }

    let result = copyValues

    var denseHash: [Int] = []
    for i in 0..<16 {
        var xorResult = 0
        let startIndex = i * 16
        for j in startIndex..<startIndex + 16 {
            xorResult = xorResult ^ result[j]
        }

        denseHash.append(xorResult)
    }

    var hexString = ""
    for hashVal in denseHash {
        let hex = String(format: "%2x", hashVal).replacingOccurrences(of: " ", with: "0")
        hexString += hex
    }

    return hexString
}

public func inputToBinaryStringArray(_ puzzleInput: String) -> [String] {

    let numElements = 256
    var elementArray: [Int] = []

    for i in 0..<numElements {
        elementArray.append(i)
    }

    var binaryArray: [String] = []

    for i in 0..<128 {
        let input = "\(puzzleInput)-\(i)"
        let hash = knotHash(values: elementArray, hashInput: input)
        var binaryString = ""
        for i in 0..<4 {
            let startIndex = hash.index(hash.startIndex, offsetBy: i*8)
            let endIndex = hash.index(startIndex, offsetBy: 8)
            let substr = String(hash[startIndex..<endIndex])

            binaryString += substr.hexToBinary.pad(with: "0", toLength: 32)
        }

        binaryArray.append(binaryString)
    }

    return binaryArray
}

public func numRegions(_ binaryArray: [[Int]]) -> Int {
    var array = binaryArray

    let numRows = array.count
    let numColumns = array[0].count

    func markAdjacent(_ x: Int, _ y: Int) {
        array[x][y] = 0

        let prevY = y - 1
        if (prevY >= 0 && array[x][prevY] == 1) {
            markAdjacent(x, prevY)
        }

        let nextY = y + 1
        if (nextY < numColumns && array[x][nextY] == 1) {
            markAdjacent(x, nextY)
        }

        let prevX = x - 1
        if (prevX >= 0 && array[prevX][y] == 1) {
            markAdjacent(prevX, y)
        }

        let nextX = x + 1
        if (nextX < numRows && array[nextX][y] == 1) {
            markAdjacent(nextX, y)
        }
    }

    var numRegions = 0

    for i in 0..<numRows {
        for j in 0..<numColumns {
            let used = array[i][j] == 1
            if (used) {
                numRegions += 1
                markAdjacent(i, j)
            }
        }
    }

    return numRegions
}
