//
//  SkillManager.swift
//  NoahKit
//
//  Created by Franklin Fox on 28/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

class SkillManager: NSObject {

    var skills : [String: Skill]
    var character : Buffable!
    var target : Attackable?
    
    init(character: Character) {
        self.character = character
        skills = [String: Skill]()
    }
    
    func addSkill(skill: Skill) {
        skill.character = character
        skills[skill.name] = skill
    }
    
    func activateSkill(name: String) {
        skills[name]!.activate(target)
    }
    
    func selectTarget(target: Character?) {
        self.target = target
    }
}
