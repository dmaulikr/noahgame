//
//  Movable.swift
//  NoahKit
//
//  Created by Franklin Fox on 29/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

protocol Movable: Localizable {

    func move(_ direction: Vector)
    func rotateRight()
    func rotateLeft()

}

protocol Localizable {
    
    var position: Vector { get set }
    var rotation: Float { get set }
    
}
