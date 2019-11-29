import Foundation

public typealias Grid = [[String]]

public struct Rule {
    public let grid: Grid
    public let toGrid: Grid
}

public func ==<Element : Equatable> (lhs: [[Element]], rhs: [[Element]]) -> Bool {
    return lhs.elementsEqual(rhs, by: ==)
}

public func flippedGrid(_ grid: Grid) -> Grid {
    var flipped = grid
    for i in 0..<grid.count {
        flipped[i] = grid[i].reversed()
    }

    return flipped
}

public func rotatedGrid(_ grid: Grid) -> Grid {
    let sideLength = grid.count

    var rotated = Array(repeatElement(Array(repeating: ".", count: sideLength), count: sideLength))

    for i in 0..<sideLength {
        for j in 0..<sideLength {
            rotated[i][j] = grid[sideLength - j - 1][i]
        }
    }

    return rotated
}

public func inputToGridRules(_ input: String) -> [Rule] {
    return input.components(separatedBy: .newlines)
        .map {
            // ../.# => ##./#../...
            // .#./..#/### => #..#/..../..../#..#
            let parts = $0.components(separatedBy: " => ")
            let gridParts = parts[0].components(separatedBy: "/")
            let toGridParts = parts[1].components(separatedBy: "/")

            func stringArrToGrid(strings: [String]) -> Grid {
                return strings.map {
                    var row: [String] = []
                    for i in 0..<$0.count {
                        let index = $0.index($0.startIndex, offsetBy: i)
                        row.append(String($0[index]))
                    }

                    return row
                }
            }

            return Rule(grid: stringArrToGrid(strings: gridParts), toGrid: stringArrToGrid(strings: toGridParts))
    }
}

private func doesGrid(_ grid: Grid, matchRule rule: Rule) -> Bool {
    if (grid == rule.grid || flippedGrid(grid) == rule.grid) {
        return true
    }

    var rotated = grid

    for _ in 0..<3 {
        rotated = rotatedGrid(rotated)
        if (rotated == rule.grid || flippedGrid(rotated) == rule.grid) {
            return true
        }
    }

    return false
}

public func numPixelsAfterIterations(startingGrid: Grid, rules: [Rule], numIterations: Int) -> Int {

    let size2Rules = rules.filter { $0.grid.count == 2 }
    let size3Rules = rules.filter { $0.grid.count == 3 }

    var grid = startingGrid

    for _ in 0..<numIterations {

        let size = grid.count

        var subGrids: [Grid] = []

        let subGridSize = size % 2 == 0 ? 2 : 3
        let sections = size / subGridSize
        let numSubGrids = sections * sections
        for c in 0..<numSubGrids {
            var subGrid = Grid()
            for i in 0..<subGridSize {
                let row = i + subGridSize * (c / sections)
                var gridRow: [String] = []
                for j in 0..<subGridSize {
                    let column = j + subGridSize * (c % sections)
                    gridRow.append(grid[row][column])
                }
                subGrid.append(gridRow)
            }
            subGrids.append(subGrid)
        }

        for (index, grid) in subGrids.enumerated() {

            if (size % 2 == 0) {
                for rule in size2Rules {
                    if (doesGrid(grid, matchRule: rule)) {
                        subGrids[index] = rule.toGrid
                    }
                }

            } else if (size % 3 == 0) {
                for rule in size3Rules {
                    if (doesGrid(grid, matchRule: rule)) {
                        subGrids[index] = rule.toGrid
                    }
                }
            }
        }

        let newSubgridSize = subGrids[0].count
        let newSize = sections * newSubgridSize
        grid = Grid(repeating: Array(repeatElement(".", count: newSize)), count: newSize)

        for (c, subGrid) in subGrids.enumerated() {
            for i in 0..<newSubgridSize {
                let row = i + newSubgridSize * (c / sections)
                for j in 0..<newSubgridSize {
                    let column = j + newSubgridSize * (c % sections)
                    grid[row][column] = subGrid[i][j]
                }
            }
        }
    }

    let onPixels = grid.joined().filter { $0 == "#" }.count

    return onPixels
}
