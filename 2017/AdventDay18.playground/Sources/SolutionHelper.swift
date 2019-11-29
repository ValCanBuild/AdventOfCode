import Foundation

public func part1(instructions: [String]) -> Int {

    var currIndex = 0
    var lastSoundPlayed = 0

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
        case "add":
            registers[reg] = getReg(reg) + value
            break
        case "mul":
            registers[reg] = getReg(reg) * value
            break
        case "mod":
            registers[reg] = getReg(reg) % value
            break
        case "snd":
            lastSoundPlayed = getReg(reg)
            break
        case "rcv":
            let val = getReg(reg)
            if (val != 0) {
                return lastSoundPlayed
            }
            break
        case "jgz":
            if (getReg(reg) > 0) {
                currIndex += value
                continue
            } else if let arg1 = Int(comp[1]) {
                if (arg1 > 0) {
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

    fatalError("Missed opportunity")
}

class Worker {
    var timesSentValue = 0
    var queue = Array<Int>()
    let instructions: [String]
    private let id: Int

    private var isWaiting = false
    private var isTerminated = false

    private var currIndex = 0
    private var registers: [String : Int] = [:]

    init (_ instructions: [String], id: Int) {
        self.instructions = instructions
        self.id = id
        registers["p"] = id
    }

    var isWaitingOrTerminated: Bool {
        get {
            return isWaiting || isTerminated
        }
    }

    private func getReg(_ reg: String) -> Int {
        if let r = registers[reg] {
            return r
        } else {
            registers[reg] = 0
            return 0
        }
    }

    public func executeStep(otherQueue: inout Array<Int>) {
        if (currIndex < 0 || currIndex >= instructions.count) {
            isTerminated = true
            print("Worker \(id) terminated")
        }

        if (isTerminated) {
            return
        }

        let instruction = instructions[currIndex]
        let comp = instruction.components(separatedBy: " ")
        let type = comp[0]

        let reg = comp[1]
        var value = 0
        if comp.count == 3 {
            value = Int(comp[2]) ?? getReg(comp[2])
        }

        switch (type) {
        case "set":
            registers[reg] = value
            currIndex += 1
        case "add":
            registers[reg] = getReg(reg) + value
            currIndex += 1
        case "mul":
            registers[reg] = getReg(reg) * value
            currIndex += 1
        case "mod":
            registers[reg] = getReg(reg) % value
            currIndex += 1
        case "snd":
            let toSend = Int(comp[1]) ?? getReg(reg)
            queue.append(toSend)
            timesSentValue += 1
            currIndex += 1
        case "rcv":
            if let valFromOther = otherQueue.first {
                registers[reg] = valFromOther
                isWaiting = false
                currIndex += 1
                otherQueue.remove(at: 0)
            } else {
                isWaiting = true
            }
        case "jgz":
            let arg = Int(comp[1]) ?? getReg(reg)
            if (arg > 0) {
                currIndex += value
            } else {
                currIndex += 1
            }
        default:
            fatalError("Unknown instruction")
        }
    }
}

public func part2(instructions: [String]) {

    let worker0 = Worker(instructions, id: 0)
    let worker1 = Worker(instructions, id: 1)

    while (!worker0.isWaitingOrTerminated || !worker1.isWaitingOrTerminated) {
        worker0.executeStep(otherQueue: &worker1.queue)
        worker1.executeStep(otherQueue: &worker0.queue)
    }

    print("Times worker 0 sent value: \(worker0.timesSentValue)")
    print("Times worker 1 sent value: \(worker1.timesSentValue)")
}
