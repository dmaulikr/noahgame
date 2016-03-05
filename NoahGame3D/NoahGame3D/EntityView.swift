//
//  EntityView.swift
//  NoahGame3D
//
//  Created by Franklin Fox on 2/3/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit
import SceneKit
import NoahKit

class EntityView: NSObject {

    var entity: Entity?
    var node: SCNNode!
    
    override init() {
        entity = nil
        node = SCNNode()
    }
    
    init(entity: Entity, nodeName: String) {
        self.entity = entity
        node = WorldScene.sharedInstance().getEntityWithName(nodeName)
    }
    
    func animate() { }
    
    var position: SCNVector3 {
        get {
            let vector: Vector = (entity?.position)!
            return SCNVector3Make(vector.y, vector.z, vector.x)
        }
    }
    
    var rotation: Float {
        get {
            return entity!.rotation
        }
    }
    
}
