//
//  Immunity.swift
//  NoahKit
//
//  Created by Franklin Fox on 29/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

class Immunity: DefensiveSkill {

    init() {
        super.init(name: SkillNames.Immunity.rawValue)
    }
    
    override func activate(target: Attackable?) {
        super.activate(nil)
        character.activateImmunity()
    }
    
}
