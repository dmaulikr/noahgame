//
//  Vector.swift
//  NoahKit
//
//  Created by Franklin Fox on 29/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

public class Vector: NSObject {

    public var x, y, z: Float
    
    init(x: Float, y: Float) {
        self.x = x
        self.y = y
        self.z = 0
    }
    
    internal func move(traslation: Vector, angle: Float) {
        var newAngle = angle
        
        if traslation.x < 0 {   // left
            newAngle += Float(M_PI)/2
        }
        
        if traslation.x > 0 {   // right
            newAngle -= Float(M_PI)/2
        }
        
        if traslation.y < 0 {   // down
            newAngle += Float(M_PI)
        }
        
        let magnitude = traslation.magnitude()
        let proyX = cos(newAngle) * magnitude
        let proyY = sin(newAngle) * magnitude
        
        self.sume(Vector(x: proyX, y: proyY))
    }
    
    func sume(vector: Vector) {
        x += vector.x
        y += vector.y
    }
    
    func magnitude() -> Float {
        return sqrt(pow(x, 2) + pow(y, 2))
    }
    
    internal static var up: Vector {
        get {
            return Vector(x: 0, y: 1)
        }
    }
    
    internal static var down: Vector {
        get {
            return Vector(x: 0, y: -1)
        }
    }
    
    internal static var right: Vector {
        get {
            return Vector(x: -1, y: 0)
        }
    }
    
    internal static var left: Vector {
        get {
            return Vector(x: 1, y: 0)
        }
    }
    
    internal static var zero: Vector {
        get {
            return Vector(x: 0, y: 0)
        }
    }
    
}
