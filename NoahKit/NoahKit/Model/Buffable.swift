//
//  Buffable.swift
//  NoahKit
//
//  Created by Franklin Fox on 29/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

public protocol Buffable: Attackable {

    func activateElectrons(_ points: Int)
    func activateImmunity()
    func activateCurrent()
    
}
