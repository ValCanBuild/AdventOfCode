import Foundation

class Distribution {
    let data: [Int]
    var timesSinceSeen: Int = 0
    
    init(data: [Int]) {
        self.data = data
    }
}

public func part1(memoryBanks: [Int]) -> Int {
    var numCycles = 0
    
    var seenDistributions: [[Int]] = [memoryBanks]
    
    var distribution: [Int] = memoryBanks
    let numElements = distribution.count
    
    while (true) {
        numCycles += 1
        
        let maxValue = distribution.max()!
        let indexOfMax = distribution.index(of: maxValue)!
        distribution[indexOfMax] = 0
        
        let numBlocks = maxValue
        var nextIndex = indexOfMax == numElements-1 ? 0 : indexOfMax+1
        for _ in 0..<numBlocks {
            distribution[nextIndex] += 1
            
            nextIndex = nextIndex == numElements-1 ? 0 : nextIndex+1
        }
        
        let seenBefore = seenDistributions.contains { $0 == distribution }
        if (seenBefore) {
            break
        }
        
        seenDistributions.append(distribution)
    }

    return numCycles
}

public func part2(memoryBanks: [Int]) -> Int {
    
    var seenDistributions: [Distribution] = [Distribution(data: memoryBanks)]
    
    var distribution: [Int] = memoryBanks
    let numElements = distribution.count
    
    while (true) {
        for var distribution in seenDistributions {
            distribution.timesSinceSeen += 1
        }
        
        let maxValue = distribution.max()!
        let indexOfMax = distribution.index(of: maxValue)!
        distribution[indexOfMax] = 0
        
        let numBlocks = maxValue
        var nextIndex = indexOfMax == numElements-1 ? 0 : indexOfMax+1
        for _ in 0..<numBlocks {
            distribution[nextIndex] += 1
            
            nextIndex = nextIndex == numElements-1 ? 0 : nextIndex+1
        }
        
        let seenDistribution = seenDistributions.first { $0.data == distribution }
        if let times = seenDistribution?.timesSinceSeen {
            return times
        }
        
        seenDistributions.append(Distribution(data: distribution))
    }
}
