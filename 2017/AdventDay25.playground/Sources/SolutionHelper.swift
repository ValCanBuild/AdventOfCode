import Foundation

public protocol State {
    func step(tape: inout [Int], cursor: inout Int) -> State
}

public enum StateNormal : State {
    case A
    case B
    case C
    case D
    case E
    case F

    public func step(tape: inout [Int], cursor: inout Int) -> State {
        let value = tape[cursor]

        switch (self) {
        case StateNormal.A:
            if (value == 0) {
                tape[cursor] = 1
                cursor += 1
                return StateNormal.B
            } else {
                tape[cursor] = 1
                cursor -= 1
                return StateNormal.E
            }
        case StateNormal.B:
            if (value == 0) {
                tape[cursor] = 1
                cursor += 1
                return StateNormal.C
            } else {
                tape[cursor] = 1
                cursor += 1
                return StateNormal.F
            }
        case StateNormal.C:
            if (value == 0) {
                tape[cursor] = 1
                cursor -= 1
                return StateNormal.D
            } else {
                tape[cursor] = 0
                cursor += 1
                return StateNormal.B
            }
        case StateNormal.D:
            if (value == 0) {
                tape[cursor] = 1
                cursor += 1
                return StateNormal.E
            } else {
                tape[cursor] = 0
                cursor -= 1
                return StateNormal.C
            }
        case StateNormal.E:
            if (value == 0) {
                tape[cursor] = 1
                cursor -= 1
                return StateNormal.A
            } else {
                tape[cursor] = 0
                cursor += 1
                return StateNormal.D
            }
        case StateNormal.F:
            if (value == 0) {
                tape[cursor] = 1
                cursor += 1
                return StateNormal.A
            } else {
                tape[cursor] = 1
                cursor += 1
                return StateNormal.C
            }
        }
    }
}

public func part1(numIterations: Int) {

    var tape: [Int] = Array(repeating: 0, count: Int(Double(numIterations) * 1.5))
    var state: State = StateNormal.A
    var cursor = tape.count / 2

    for _ in 0..<numIterations {
        state = state.step(tape: &tape, cursor: &cursor)
    }

    let checksum = tape.filter { $0 == 1 }.count
    print("Checksum after \(numIterations) iterations is \(checksum)")
}
