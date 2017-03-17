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
    var skills: [String: Skill]!
    
    init(personage: Personage) {
        super.init()
        
        self.personage = personage
        skills = [String: Skill]()
        
        NotificationCenter.default.addObserver(self, selector: #selector(SkillManager.activateSkillNotify(_:)), name: NSNotification.Name(rawValue: OperationNames.ActivateSkill.rawValue), object: nil)
    }
    
    func addSkill(_ skill: Skill) {
        skill.personage = personage
        skills[skill.name] = skill
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: OperationNames.AddSkill.rawValue), object: skill)
    }
    
    func activateSkill(_ name: String) {
        skills[name]?.activateSkill(target)
    }
    
    func activateSkillNotify(_ notification: Notification) {
        let message = notification.object as! NSDictionary
        let personageName = message["personage"] as! String
        let skillName = message["skillName"] as! String
        let targetName = message["target"] as? String
        
        let skill = skills[skillName]
        
        if skill is OffensiveSkill {
            if targetName == personage.name {
                skill?.activate(personage)
            }
        } else {
            if personageName == personage.name {
                skill?.activate(nil)
            }
        }
    }
    
}
