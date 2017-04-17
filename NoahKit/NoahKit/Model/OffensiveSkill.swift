//
//  OffensiveSkill.swift
//  NoahKit
//
//  Created by Franklin Fox on 28/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

class OffensiveSkill: Skill {
    
    var range: Float
    
    init(name: SkillName,
         cost: Int,
         points: Int = 0,
         reload: Int = 0,
         duration: Int = 0,
         range: Float = 0,
         description: String = "") {
        
        self.range = range
        
        super.init(name: name,
                   cost: cost,
                   points: points,
                   reload: reload,
                   duration: duration,
                   description: description)
    }

    override func activateSkill(_ personage: Buffable, target: Attackable) {
        
        if personage.isNear(target, range: range) {
            super.activateSkill(personage, target: target)
            target.receiveOffensiveSkill(self)
        }
        
    }
    
}
