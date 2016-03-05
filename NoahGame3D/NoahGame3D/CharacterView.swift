//
//  CharacterView.swift
//  NoahGame3D
//
//  Created by Franklin Fox on 1/3/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import SceneKit
import NoahKit

class CharacterView: EntityView {
    
    override init() {
        super.init(entity: Character(name: "Character"), nodeName: "ship")
    }
    
    override func animate() {
        let action = SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 2, z: 0, duration: 1))
        node.runAction(action)
    }
    
    func move(offset: Float) {
        let character = entity as! NoahKit.Character
        
        if offset < 0 {
            character.moveUp()
        } else {
            character.moveDown()
        }
        
        node.position = position
        print(node.position)
    }
    
    func rotate(offset: Float) {
        let character = entity as! NoahKit.Character
        
        if offset < 0 {
            character.rotateLeft()
        } else {
            character.rotateRight()
        }
        
        node.eulerAngles.y = entity!.rotation
    }
    
}
