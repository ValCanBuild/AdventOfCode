import Foundation

public enum Direction {
    case Up
    case Down
    case Left
    case Right
}

public struct Coord : Hashable {
    public var x: Int
    public var y: Int

    public init (_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    public var hashValue: Int {
        return x.hashValue ^ y.hashValue &* 16777619
    }

    public static func == (lhs: Coord, rhs: Coord) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

public class Virus {
    public var coord: Coord
    public var facing: Direction = .Up

    public init(_ coord: Coord) {
        self.coord = coord
    }

    public func turnLeft() {
        switch facing {
        case .Up:
            facing = .Left
        case .Down:
            facing = .Right
        case .Left:
            facing = .Down
        case .Right:
            facing = .Up
        }
    }

    public func turnRight() {
        switch facing {
        case .Up:
            facing = .Right
        case .Down:
            facing = .Left
        case .Left:
            facing = .Up
        case .Right:
            facing = .Down
        }
    }

    public func turnAround() {
        switch facing {
        case .Up:
            facing = .Down
        case .Down:
            facing = .Up
        case .Left:
            facing = .Right
        case .Right:
            facing = .Left
        }
    }

    public func move() {
        switch facing {
        case .Up:
            coord.y -= 1
        case .Down:
            coord.y += 1
        case .Left:
            coord.x -= 1
        case .Right:
            coord.x += 1
        }
    }
}

public func part1(_ iterations: Int, inputMap: [[Bool]]) -> Int {
    var gridDict: [Coord : Bool] = [:]
    for i in 0..<inputMap.count {
        for j in 0..<inputMap[i].count {
            let coord = Coord(j, i)
            gridDict[coord] = inputMap[i][j]
        }
    }

    let centreX = inputMap.count / 2
    let centreY = centreX

    let virus = Virus(Coord(centreX, centreY))

    var numMovesInfections = 0

    for _ in 0..<iterations {
        let currNodeInfected = gridDict[virus.coord] ?? false
        if (currNodeInfected) {
            virus.turnRight()
            gridDict[virus.coord] = false
        } else {
            numMovesInfections += 1
            gridDict[virus.coord] = true
            virus.turnLeft()
        }



        virus.move()
    }

    return numMovesInfections
}

public func part2(_ iterations: Int, inputMap: [[Bool]]) -> Int {
    enum NodeState {
        case Clean
        case Weakened
        case Infected
        case Flagged

        func nextState() -> NodeState {
            switch (self) {
            case .Clean: return .Weakened
            case .Weakened: return .Infected
            case .Infected: return .Flagged
            case .Flagged: return .Clean
            }
        }
    }

    var gridDict: [Coord : NodeState] = [:]
    for i in 0..<inputMap.count {
        for j in 0..<inputMap[i].count {
            let coord = Coord(j, i)
            gridDict[coord] = inputMap[i][j] ? .Infected : .Clean
        }
    }

    let centreX = inputMap.count / 2
    let centreY = centreX

    let virus = Virus(Coord(centreX, centreY))

    var numMovesInfections = 0

    for _ in 0..<iterations {
        let currNodeState = gridDict[virus.coord] ?? .Clean
        switch (currNodeState) {
        case .Clean:
            virus.turnLeft()
        case .Weakened:
            break
        case .Infected:
            virus.turnRight()
        case .Flagged:
            virus.turnAround()
        }

        let nextState = currNodeState.nextState()
        gridDict[virus.coord] = nextState

        if (nextState == .Infected) {
            numMovesInfections += 1
        }

        virus.move()
    }

    return numMovesInfections
}
