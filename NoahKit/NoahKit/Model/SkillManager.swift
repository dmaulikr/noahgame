//
//  SkillManager.swift
//  NoahKit
//
//  Created by Franklin Fox on 28/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

class SkillManager: NSObject {

    var personage: Buffable!
    internal var target: Attackable?
    var skills: [String: Skill]
    
    init(personage: Personage) {
        self.personage = personage
        skills = [String: Skill]()
    }
    
    func addSkill(skill: Skill) {
        skill.personage = personage
        skills[skill.name] = skill
        
        NSNotificationCenter.defaultCenter().postNotificationName("personageAddSkill", object: skill)
    }
    
    func activateSkill(name: String) {
        skills[name]?.activate(target)
    }
    
}
