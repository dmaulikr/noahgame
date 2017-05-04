//
//  Vector.swift
//  NoahKit
//
//  Created by Franklin Fox on 29/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import Foundation

public class Vector {

    public var x, y, z: Float
    
    init(x: Float, y: Float) {
        self.x = x
        self.y = y
        self.z = 0
    }
    
    func move(_ traslation: Vector, angle: Float) {
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
        
        let velocity: Float = 10
        let magnitude = traslation.magnitude() * velocity
        let proyX = cos(newAngle) * magnitude
        let proyY = sin(newAngle) * magnitude
        
        let vector = self + Vector(x: proyX, y: proyY)
        x = vector.x
        y = vector.y
    }
    
    func magnitude() -> Float {
        return sqrt(pow(x, 2) + pow(y, 2))
    }
    
    static func +(vector1: Vector, vector2: Vector) -> Vector {
        vector1.x += vector2.x
        vector1.y += vector2.y
        return vector1
    }
    
    static func -(vector1: Vector, vector2: Vector) -> Vector {
        vector1.x -= vector2.x
        vector1.y -= vector2.y
        return vector1
    }
    
    //
    public static var up: Vector {
        get { return Vector(x: 0, y: 1) }
    }
    
    public static var down: Vector {
        get { return Vector(x: 0, y: -1) }
    }
    
    public static var right: Vector {
        get { return Vector(x: -1, y: 0) }
    }
    
    public static var left: Vector {
        get { return Vector(x: 1, y: 0) }
    }
    
    public static var zero: Vector {
        get { return Vector(x: 0, y: 0) }
    }
    
}
