import Foundation

public struct Layer {
    public let depth: Int
    public let range: Int

    public init(depth: Int, range: Int) {
        self.depth = depth
        self.range = range
    }

    public var severity: Int {
        get {
            return depth * range
        }
    }
}

public func calculateSeverityOfTrip(layers: [Int : Layer], maxDepth: Int, startingDelay: Int = 0, skipIfCaught: Bool = false) -> (Int, Bool) {
    var currentIndex = 0
    var severity = 0
    var iteration = startingDelay
    var isCaught = false

    while (currentIndex <= maxDepth) {

        if let layer = layers[currentIndex] {

            if (iteration % ((layer.range - 1) * 2) == 0) {
                isCaught = true
                severity += layer.severity
                if (skipIfCaught) {
                    return (severity, isCaught)
                }
            }
        }

        currentIndex += 1
        iteration += 1
    }

    return (severity, isCaught)
}

public func calculateNumSkipsToPass(layers: [Int : Layer], maxDepth: Int) -> Int {
    var delay = 0
    while (calculateSeverityOfTrip(layers: layers, maxDepth: maxDepth, startingDelay: delay, skipIfCaught: true).1) {
        delay += 1
    }

    return delay
}
