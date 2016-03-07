//
//  Entity.swift
//  NoahKit
//
//  Created by Franklin Fox on 2/3/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

public class Entity: NSObject {
    
    public var position: Vector!
    public var rotation: Float = 0
    
    override init() {
        position = Vector.zero
    }

}
