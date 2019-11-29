import Foundation

public struct Program {
    public let id: Int
    public let connectedIds: [Int]

    public init(id: Int, connectedIds: [Int]) {
        self.id = id
        self.connectedIds = connectedIds
    }
}

public func findAllProgramsConnectedToProgram(_ targetProgram: Program, inAllPrograms allPrograms: [Program]) -> Set<Int> {
    var connectedIdSet: Set<Int> = Set(targetProgram.connectedIds)
    connectedIdSet.insert(targetProgram.id)

    func findConnectedPrograms(toProgram program: Program) {
        let ids = program.connectedIds.filter { $0 != program.id && !connectedIdSet.contains($0) }
        connectedIdSet = connectedIdSet.union(ids)

        let subPrograms = ids.map { (id) -> Program in
            return allPrograms.first { $0.id == id }!
        }

        for subProgram in subPrograms {
            findConnectedPrograms(toProgram: subProgram)
        }
    }


    for connectedId in targetProgram.connectedIds {
        let connectedBaseProgram = allPrograms.first { $0.id == connectedId }!
        findConnectedPrograms(toProgram: connectedBaseProgram)
    }

    return connectedIdSet
}

public func findNumGroupsInSetOfAllPrograms(allProgramsIdSet: Set<Int>, allPrograms: [Program]) -> Int {
    var remainingSet = allProgramsIdSet
    var numGroups = 0

    while (!remainingSet.isEmpty) {
        let firstProgramId = remainingSet.first!
        let firstProgram = allPrograms.first { $0.id == firstProgramId }!

        let programs = remainingSet.map { (id) -> Program in return allPrograms.first { $0.id == id }! }
        let connectedIdSet = findAllProgramsConnectedToProgram(firstProgram, inAllPrograms: programs)

        remainingSet = remainingSet.subtracting(connectedIdSet)
        numGroups += 1
    }

    return numGroups
}
