//
//  SkillsManager.swift
//  NoahKit
//
//  Created by Franklin Fox on 28/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

class SkillsManager {

    var personage: Buffable
    var skills: [SkillName: Skill]
    
    init(personage: Buffable) {
        self.personage = personage
        skills = [:]
        
        SkillsBuilder.shared.setup(self)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(activateSkillNotify(_:)), name: NSNotification.Name(rawValue: OperationNames.activateSkill.rawValue), object: nil)
    }
    
    func addSkill(_ skill: Skill) {
        skills[skill.name] = skill
        
//        NotificationCenter.default.post(name: Notification.Name(rawValue: OperationNames.addSkill.rawValue), object: skill)
    }
    
    func activateSkill(_ name: SkillName, target: Attackable) {
        skills[name]?.activateSkill(personage, target: target)
    }
    
    /*func activateSkillNotify(_ notification: Notification) {
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
    }*/
    
}
