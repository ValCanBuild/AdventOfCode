import Foundation

extension String {
    public func pad(with padding: Character, toLength length: Int) -> String {
        let paddingWidth = length - self.count
        guard 0 < paddingWidth else { return self }

        return String(repeating: padding, count: paddingWidth) + self
    }
}

public class Generator {
    var lastValue: Int
    let factor: Int

    public init(input: Int, factor: Int) {
        self.lastValue = input
        self.factor = factor
    }

    public func generateNextValue() -> Int {
        let next = (lastValue * factor) % 2147483647
        lastValue = next
        return next
    }

    public func generateNextValue(multipleOf: Int) -> Int {
        let next = (lastValue * factor) % 2147483647
        lastValue = next
        if (next % multipleOf == 0) {
            return next
        } else {
            return -1
        }
    }
}

public func findPairsPart1(_ generatorA: Generator, _ generatorB: Generator, _ numIterations: Int) -> Int {
    var numMatching = 0

    for _ in 0..<numIterations {
        let valA = generatorA.generateNextValue()
        let valB = generatorB.generateNextValue()

        if (valA % 65536 == valB % 65536) {
            numMatching += 1
        }
    }

    return numMatching
}

public func findPairsPart2(_ generatorA: Generator, _ generatorB: Generator, _ numIterations: Int) -> Int {
    var numMatching = 0

    for _ in 0..<numIterations {
        var valA = 0
        var valB = 0

        repeat {
            valA = generatorA.generateNextValue(multipleOf: 4)
        } while (valA == -1)

        repeat {
            valB = generatorB.generateNextValue(multipleOf: 8)
        } while (valB == -1)

        if (valA % 65536 == valB % 65536) {
            numMatching += 1
        }
    }

    return numMatching
}
