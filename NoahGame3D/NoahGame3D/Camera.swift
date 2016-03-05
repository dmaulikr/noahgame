//
//  Camera.swift
//  NoahGame3D
//
//  Created by Franklin Fox on 1/3/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit
import SceneKit

class Camera: NSObject {
    
    let orbit: SCNNode
    var node: SCNNode
    var target: EntityView?

    override init() {
        orbit = SCNNode()
        node = SCNNode()
        super.init()
        
        node.camera = SCNCamera()
        node.camera?.usesOrthographicProjection = true
        node.camera?.orthographicScale = 20
        node.camera?.zFar = 200
        
        orbit.addChildNode(node)
        
        self.position = SCNVector3(x: 0, y: 20, z: 20)
    }
    
    var position: SCNVector3 {
        get {
            return  node.position
        }
        set {
            node.position = newValue
        }
    }
    
    func addTarget(target: EntityView) {
        self.target = target
        
        let constraint = SCNLookAtConstraint(target: target.node)
        constraint.gimbalLockEnabled = true
        node.constraints = [constraint]
    }
    
    func moveWithTarget() {
        orbit.position = target!.position
    }
    
    func rotateWithTarget() {
        orbit.eulerAngles.y = target!.rotation
    }

}
