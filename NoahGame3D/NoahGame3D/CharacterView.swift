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
//        super.init()
//        node.geometry = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
//        node.geometry?.firstMaterial?.diffuse.contents = UIColor.brownColor()
//        node.position = SCNVector3(0, 5, 0)
    }
    
    override func animate() {
        let action = SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 2, z: 0, duration: 1))
        node.runAction(action)
    }
    
    func move(traslation: SCNVector3) {
        let vector = SCNVector3Make(node.position.x + traslation.x, node.position.y + traslation.y, node.position.z + traslation.z)
//        
//        let vector2 = SCNVector4Make(<#T##x: Float##Float#>, <#T##y: Float##Float#>, <#T##z: Float##Float#>, <#T##w: Float##Float#>)
//        node.orientation = SCNQuaternion(
        node.position = vector
    
        print("move \(node.position)")
    }
    
    func rotate(rotate: Float) {
        let character = entity as! NoahKit.Character
        
        if rotate < 0 {
            character.rotateRight()
        } else {
            character.rotateLeft()
        }
        
        node.eulerAngles.y = entity!.rotation
        
//        node.eulerAngles.y += (rotate / 180)
//        entity?.rotation = node.eulerAngles.y
        
        print("rotate \(node.eulerAngles.y) entity \(entity?.rotation)")
    }
    
}
