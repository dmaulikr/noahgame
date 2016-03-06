//
//  SkillManager.swift
//  NoahKit
//
//  Created by Franklin Fox on 28/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

class SkillManager: NSObject {

    var character: Buffable!
    internal var target: Attackable?
    var skills: [String: Skill]
    
    init(character: Character) {
        self.character = character
        skills = [String: Skill]()
    }
    
    func addSkill(skill: Skill) {
        skill.character = character
        skills[skill.name] = skill
        
        NSNotificationCenter.defaultCenter().postNotificationName("characterAddSkill", object: skill)
    }
    
    func activateSkill(name: String) {
        skills[name]?.activate(target)
    }
    
}
