import Foundation
import SceneKit

// Based on https://github.com/devindazzle/SCNVector3Extensions
public extension SCNVector3
{
    public func fastLength() -> Float {
        return abs(x) + abs(y) + abs(z)
    }
}

/**
 * Adds two SCNVector3 vectors and returns the result as a new SCNVector3.
 */
public func + (left: SCNVector3, right: SCNVector3) -> SCNVector3 {
    return SCNVector3Make(left.x + right.x, left.y + right.y, left.z + right.z)
}

/**
 * Increments a SCNVector3 with the value of another.
 */
public func += (left: inout SCNVector3, right: SCNVector3) {
    left = left + right
}
