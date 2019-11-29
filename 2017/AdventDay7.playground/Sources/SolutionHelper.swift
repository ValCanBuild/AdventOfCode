import Foundation

public struct Tower {
    public let name: String
    public let weight: Int
    public let towerNamesAbove: [String]
    
    public init(name: String, weight: Int, towersAbove: [String] = []) {
        self.name = name
        self.weight = weight
        self.towerNamesAbove = towersAbove
    }
}

public class Node {
    public let name: String
    public let weight: Int
    public weak var parent: Node? = nil
    public var children: [Node] = [] {
        didSet {
            for child in children {
                child.parent = self
            }
        }
    }

    init(_ tower: Tower) {
        self.name = tower.name
        self.weight = tower.weight
    }

    public var combinedWeight: Int {
        get {
            let childrenWeight = children.map { $0.combinedWeight }.reduce(0, +)
            return weight + childrenWeight
        }
    }

    public var isBalanced: Bool {
        get {
            let childWeights = children.map { $0.combinedWeight }
            return Set(childWeights).count == 1
        }
    }

    public var unbalancedChild: (Node, Int) {
        get {
            var weightNodeDict: [Int : [Node]] = [:]
            for child in children {
                if weightNodeDict[child.combinedWeight] != nil {
                    weightNodeDict[child.combinedWeight]!.append(child)
                } else {
                    weightNodeDict[child.combinedWeight] = [child]
                }
            }

            let targetWeight = weightNodeDict.first { $0.value.count > 1 }!.key
            let unbalancedChild = weightNodeDict.first { $0.value.count == 1 }!.value.first!

            return (unbalancedChild, targetWeight)
        }
    }

}

public func inputToTowers(input: String) -> [Tower] {
    let inputLines = input.components(separatedBy: .newlines)
    
    let towers: [Tower] = inputLines.map {
        let stringParts = $0.components(separatedBy: .whitespaces)
        
        let name = stringParts[0]
        
        let weightPart = stringParts[1]
        let start = weightPart.index(after: weightPart.startIndex)
        let end = weightPart.index(before: weightPart.endIndex)
        let weight = Int(weightPart[start..<end])!
        
        var towerNamesAbove: [String] = []
        let hasTowers = stringParts.count > 2
        if hasTowers {
            for i in 3..<stringParts.count {
                let towerName = stringParts[i].replacingOccurrences(of: ",", with: "")
                towerNamesAbove.append(towerName)
            }
        }
        
        return Tower(name: name, weight: weight, towersAbove: towerNamesAbove)
    }
    
    return towers
}

public func inputToNodes(_ input: String) -> [Node] {
    let towers = inputToTowers(input: input)
    let nodes: [Node] = towers.map { Node($0) }

    let towersWithTowers = towers.filter { !$0.towerNamesAbove.isEmpty }
    for tower in towersWithTowers {
        let node = nodes.first { $0.name == tower.name }!
        node.children = tower.towerNamesAbove.map { name in
            return nodes.first { $0.name == name }!
        }
    }

    return nodes
}

public func part1(_ input: String) -> String {

    let nodes: [Node] = inputToNodes(input)

    let topNode = nodes.first { $0.parent == nil }!
    return topNode.name
}

public func part2(_ input: String) -> (Int, String) {

    let nodes: [Node] = inputToNodes(input)

    var node = nodes.first { $0.parent == nil }!
    var targetWeight = 0

    while (!node.isBalanced) {
        (node, targetWeight) = node.unbalancedChild
    }

    let weightDiff = targetWeight - node.combinedWeight
    let weightNeeded = node.weight + weightDiff
    return (weightNeeded, node.name)
}
