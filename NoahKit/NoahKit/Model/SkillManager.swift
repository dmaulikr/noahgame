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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "activateSkillNotify:", name: OperationNames.ActivateSkill.rawValue, object: nil)
    }
    
    func addSkill(skill: Skill) {
        skill.personage = personage
        skills[skill.name] = skill
        
        NSNotificationCenter.defaultCenter().postNotificationName(OperationNames.AddSkill.rawValue, object: skill)
    }
    
    func activateSkill(name: String) {
        skills[name]?.activateSkill(target)
    }
    
    func activateSkillNotify(notification: NSNotification) {
        let message = notification.object as! NSDictionary
        let personageName = message["personage"] as! String
        let skillName = message["skillName"] as! String
        let targetName = message["target"] as? String
        
        let skill = skills[skillName]
        
        if skill is OffensiveSkill {
            if targetName == personage.name {
                
            }
        } else {
            if personageName == personage.name {
                skill!.activate(nil)
            }
        }
        
        print(message["personage"])
        print(message["skillName"])
        print(message["target"])
        
        print(personage.health)
        print(personage.energy)
    }
    
}
