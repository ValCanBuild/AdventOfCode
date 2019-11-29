import Foundation

public enum Step {
    case North
    case NorthEast
    case SouthEast
    case South
    case SouthWest
    case NorthWest
}

public func solution(_ steps: [Step]) {
    print("Total count is \(distanceTravelled(steps: steps))")

    var subSteps: [Step] = []
    var maxDistance = 0
    for step in steps {
        subSteps.append(step)
        maxDistance = max(maxDistance, distanceTravelled(steps: subSteps))
    }

    print("Max distance travelled is \(maxDistance)")
}

public func distanceTravelled(steps: [Step]) -> Int {
    var numNorth = steps.filter { $0 == .North }.count
    var numSouth = steps.filter { $0 == .South }.count
    var numSouthEast = steps.filter { $0 == .SouthEast }.count
    var numSouthWest = steps.filter { $0 == .SouthWest }.count
    var numNorthEast = steps.filter { $0 == .NorthEast }.count
    var numNorthWest = steps.filter { $0 == .NorthWest }.count

    var stepsDict: [Step : Int] = [
        .North : numNorth,
        .South : numSouth,
        .SouthEast : numSouthEast,
        .SouthWest : numSouthWest,
        .NorthEast : numNorthEast,
        .NorthWest : numNorthWest
    ]

    func cancelSteps(_ step1: Step, _ step2: Step) -> Int {
        let cancelled = min(stepsDict[step1]!, stepsDict[step2]!)
        stepsDict[step1]! -= cancelled
        stepsDict[step2]! -= cancelled
        return cancelled
    }

    cancelSteps(.North, .South)
    cancelSteps(.NorthEast, .SouthWest)
    cancelSteps(.NorthWest, .SouthEast)

    stepsDict[.North]! += cancelSteps(.NorthEast, .NorthWest)
    stepsDict[.South]! += cancelSteps(.SouthEast, .SouthWest)
    stepsDict[.NorthEast]! += cancelSteps(.SouthEast, .North)
    stepsDict[.SouthEast]! += cancelSteps(.NorthEast, .South)
    stepsDict[.SouthWest]! += cancelSteps(.South, .NorthWest)
    stepsDict[.NorthWest]! += cancelSteps(.North, .SouthWest)

    let totalCount = stepsDict.values.reduce(0, +)
    return totalCount
}
