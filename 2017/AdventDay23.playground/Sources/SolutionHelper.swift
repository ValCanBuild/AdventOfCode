import Foundation

public func part1(instructions: [String]) -> Int {

    var currIndex = 0
    var numTimesMul = 0

    var registers: [String : Int] = [:]

    func getReg(_ reg: String) -> Int {
        if let r = registers[reg] {
            return r
        } else {
            registers[reg] = 0
            return 0
        }
    }

    while (currIndex >= 0 && currIndex < instructions.count) {
        let instruction = instructions[currIndex]
        if (instruction == "empty") {
            currIndex += 1
            continue
        }
        let comp = instruction.components(separatedBy: " ")
        let type = comp[0]

        let reg = comp[1]
        var value = 0
        if comp.count == 3 {
            if let integer = Int(comp[2]) {
                value = integer
            } else {
                value = getReg(comp[2])
            }
        }


        switch (type) {
        case "set":
            registers[reg] = value
            break
        case "sub":
            registers[reg] = getReg(reg) - value
            break
        case "mul":
            registers[reg] = getReg(reg) * value
            numTimesMul += 1
            break
        case "jnz":
            if (getReg(reg) != 0) {
                currIndex += value
                continue
            } else if let arg1 = Int(comp[1]) {
                if (arg1 != 0) {
                    currIndex += value
                    continue
                }
            }
            break
        default:
            fatalError("Unknown instruction")
        }

        currIndex += 1
    }

    return numTimesMul
}

func isPrime(_ number: Int) -> Bool {
    let maxDivider = Int(sqrt(Double(number)))
    return number > 1 && !(2..<maxDivider).contains { number % $0 == 0 }
}

public func part2NonAssembly() -> Int {
    var h = 0

    for b in stride(from: 105700, through: 122700+1, by: 17) {
        var f = 1
        for d in 2...b {
            for e in 2...b {
                let g = d * e
                if (g == b) {
                    f = 0
                }
            }
        }

        if (f == 0) {
            h += 1
        }
    }

    return h
}

public func part2Optimised() -> Int {
    var h = 0

    for b in stride(from: 105700, to: 122700+1, by: 17) {
        if (!isPrime(b)) {
            h += 1
        }
    }

    return h
}
