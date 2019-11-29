import Foundation

public func knotHash(values: [Int], lengths: [Int], startSkipSize: Int, startCurrentPos: Int) -> ([Int], Int, Int) {

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
