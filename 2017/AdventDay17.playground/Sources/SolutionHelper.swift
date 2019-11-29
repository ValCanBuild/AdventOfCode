import Foundation

public func part1(steps: Int, input: Int) -> Int {
    var buf: [Int] = [0]
    var lastPos = 0

    for i in 1...steps {
        let newLength = buf.count
        let index = lastPos + input
        let pos = (index % newLength) + 1
        buf.insert(i, at: pos)
        lastPos = pos
    }

    return buf[lastPos+1]
}

public func part2(steps: Int, input: Int) -> Int {
    var lastPos = 0
    var valAt1 = 0

    for i in 1...steps {
        let index = lastPos + input
        let pos = (index % i) + 1
        lastPos = pos

        if (pos == 1) {
            valAt1 = i
        }
    }

    return valAt1
}
