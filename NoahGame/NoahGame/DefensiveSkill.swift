//
//  DefensiveSkill.swift
//  NoahKit
//
//  Created by Franklin Fox on 28/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

class DefensiveSkill: Skill {

    override func activateSkill(_ personage: Buffable, target: Attackable) {
        super.activateSkill(personage, target: target)
        
        personage.receiveDefensiveSkill(self)
    }
    
}
