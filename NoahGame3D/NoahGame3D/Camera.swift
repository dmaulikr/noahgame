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
    
    let node : SCNNode

    override init() {
        node = SCNNode()
        super.init()
        
        node.camera = SCNCamera()
        self.position = SCNVector3(x: 0, y: 3, z: 20)
    }
    
    var position : SCNVector3 {
        get {
            return node.position
        }
        set {
            node.position = newValue
        }
    }

}
