//
//  Skill.swift
//  NoahKit
//
//  Created by Franklin Fox on 28/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

class Skill {
    
    var name: SkillName
    var cost: Int
    var points: Int
    var reload: Int
    var duration: Int
    var description: String

    init(name: SkillName,
         cost: Int,
         points: Int = 0,
         reload: Int = 0,
         duration: Int = 0,
         description: String = "") {
        
        self.name       = name
        self.cost       = cost
        self.points     = points
        self.reload     = reload
        self.duration   = duration
        self.description = description
    }
    
    func activateSkill(_ personage: Buffable, target: Attackable) {
        personage.consumeEnergy(self)
        
        print("\(personage.name) attack to: \(target.name)")
        //Server.shared.activateSkill(personage, skill: self, target: target)
    }
    
}
