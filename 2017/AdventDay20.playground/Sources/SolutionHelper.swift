import Foundation
import SceneKit

public class Particle {
    public var pos: SCNVector3
    private var vel: SCNVector3
    private let acc: SCNVector3

    public init(pos: SCNVector3, vel: SCNVector3, acc: SCNVector3) {
        self.pos = pos
        self.vel = vel
        self.acc = acc
    }

    public func update() {
        vel += acc
        pos += vel
    }
}

extension Particle : CustomStringConvertible {
    public var description: String {
        get {
            return "Pos: \(pos) Vel: \(vel) Acc: \(acc)"
        }
    }
}

extension SCNVector3 : Hashable {
    public var hashValue: Int {
        return x.hashValue ^ y.hashValue ^ z.hashValue &* 16777619
    }

    public static func == (lhs: SCNVector3, rhs: SCNVector3) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
}

public func inputToParticles(_ input: String) -> [Particle] {
    return input.components(separatedBy: .newlines)
        .map {
            // p=<3,0,0>, v=<2,0,0>, a=<-1,0,0>
            let parts = $0.components(separatedBy: ", ")

            func startEndForPart(_ part: String) -> (String.Index, String.Index) {
                let start = part.index(part.index(of: "<")!, offsetBy: 1)
                let end = part.index(of: ">")!

                return (start, end)
            }

            // position
            let posIndexes = startEndForPart(parts[0])
            let posParts = parts[0][posIndexes.0..<posIndexes.1].components(separatedBy: ",")
            let pos = SCNVector3(Int(posParts[0])!, Int(posParts[1])!, Int(posParts[2])!)

            // vel
            let velIndexes = startEndForPart(parts[1])
            let velParts = parts[1][velIndexes.0..<velIndexes.1].components(separatedBy: ",")
            let vel = SCNVector3(Int(velParts[0])!, Int(velParts[1])!, Int(velParts[2])!)

            // acc
            let accIndexes = startEndForPart(parts[2])
            let accParts = parts[2][accIndexes.0..<accIndexes.1].components(separatedBy: ",")
            let acc = SCNVector3(Int(accParts[0])!, Int(accParts[1])!, Int(accParts[2])!)

            return Particle(pos: pos, vel: vel, acc: acc)
    }
}

public func findClosestParticleAfterUpdates(_ numUpdates: Int, particles: [Particle]) -> Int {
    for _ in 0..<numUpdates {
        for particle in particles {
            particle.update()
        }
    }

    var minIndex = -1
    var minDistance = Float.greatestFiniteMagnitude

    for (index, particle) in particles.enumerated() {
        let length = particle.pos.fastLength()
        if (length < minDistance) {
            minDistance = length
            minIndex = index
        }
    }

    return minIndex
}

public func numParticlesAfterCollisions(numUpdates: Int, allParticles: [Particle]) -> Int {

    var particles = allParticles

    for _ in 0..<numUpdates {

        var posParticleDict: [SCNVector3 : [Particle] ] = [:]

        for particle in particles {
            particle.update()

            if posParticleDict[particle.pos] != nil {
                posParticleDict[particle.pos]?.append(particle)
            } else {
                posParticleDict[particle.pos] = [particle]
            }
        }

        let collidingParticles = posParticleDict.filter { $1.count > 1 }.values.joined()

        for collided in collidingParticles {
            let index = particles.index { $0 === collided }!
            particles.remove(at: index)
        }

    }

    return particles.count
}
