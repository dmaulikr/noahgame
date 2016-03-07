//
//  Immunity.swift
//  NoahKit
//
//  Created by Franklin Fox on 29/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

public class Immunity: DefensiveSkill {

    public init() {
        super.init(name: SkillNames.Immunity.rawValue)
    }
    
    override func activate(target: Attackable?) {
        super.activate(nil)
        personage.activateImmunity()
    }
    
}
