//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport
import SceneKit

let inputUrl = Bundle.main.url(forResource: "Input", withExtension: ".txt")!
let input = try String(contentsOf: inputUrl)

let particles = inputToParticles(input)
print("Starting particles: \(particles.count)")
let numUpdates = 10000
print("Closest particle after \(numUpdates) updates is \(findClosestParticleAfterUpdates(numUpdates, particles: particles))")
print("Num particles after \(numUpdates) updates is \(numParticlesAfterCollisions(numUpdates: numUpdates, allParticles: particles))")
