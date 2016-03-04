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
    
}
