import Foundation

typealias Pin = Int

public struct Port : Equatable {
    let pinA: Pin
    let pinB: Pin

    var strength: Int {
        get {
            return pinA + pinB
        }
    }

    public static func ==(lhs: Port, rhs: Port) -> Bool {
        return lhs.pinA == rhs.pinA && lhs.pinB == rhs.pinB
    }
}

public class Node {
    public let port: Port
    public var children: [Node] = []
    public weak var parent: Node?
    public var visited = false

    public init(_ port: Port, remainingPorts: [Port], parent: Node? = nil) {
        self.port = port
        self.parent = parent

        var freePin = -1

        if (parent == nil) {
            freePin = port.pinA == 0 ? port.pinB : port.pinA
        } else {
            let parentPort = parent!.port
            if (port.pinA == parentPort.pinA || port.pinA == parentPort.pinB) {
                freePin = port.pinB
            } else {
                freePin = port.pinA
            }
        }

        let possibleChildren = remainingPorts.filter { $0.pinA == freePin || $0.pinB == freePin }
        for possibleChild in possibleChildren {
            let remaining = remainingPorts.filter { $0 != possibleChild && $0 != port }
            children.append(Node(possibleChild, remainingPorts: remaining, parent: self))
        }
    }
}

public func inputToPorts(_ input: String) -> [Port] {
    return input.components(separatedBy: .newlines)
        .map {
            let comp = $0.components(separatedBy: "/")
            return Port(pinA: Int(comp[0])!, pinB: Int(comp[1])!)
    }
}

private func depthFirstSearch(rootNode: Node, visitedNodeAction: (Node) -> Void) {
    rootNode.visited = true
    visitedNodeAction(rootNode)
    for node in rootNode.children {
        if (!node.visited) {
            depthFirstSearch(rootNode: node, visitedNodeAction: visitedNodeAction)
        }
    }
}

public func solution(_ input: String) -> (Int, Int) {
    let ports = inputToPorts(input)

    let root = Node(Port(pinA: 0, pinB: 0), remainingPorts: ports)
    
    var leafNodes: [Node] = []
    depthFirstSearch(rootNode: root) {
        if ($0.children.isEmpty) {
            leafNodes.append($0)
        }
    }

    var maxStrength = 0
    var maxStrengthLongest = 0
    var maxLength = 0
    for node in leafNodes {
        var nextNode: Node? = node
        var totalStrength = 0
        var totalLength = 1
        while (nextNode != nil) {
            totalLength += 1
            totalStrength += nextNode!.port.strength
            nextNode = nextNode?.parent
        }

        if (totalLength >= maxLength) {
            maxLength = totalLength
            maxStrengthLongest = max(maxStrengthLongest, totalStrength)
        }

        maxStrength = max(maxStrength, totalStrength)
    }

    return (maxStrength, maxStrengthLongest)
}
