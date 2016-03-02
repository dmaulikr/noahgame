//
//  TerrainView.swift
//  NoahGame3D
//
//  Created by Franklin Fox on 2/3/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit
import SceneKit

class TerrainView: EntityView {
    
    override init() {
        super.init()
        node.geometry = SCNFloor()
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.greenColor()
    }
    
}
