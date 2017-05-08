//
//  SkillsBuilder.swift
//  NoahKit
//
//  Created by Franklin Fox on 4/16/17.
//  Copyright © 2017 FoxDev. All rights reserved.
//

class SkillsBuilder {
    
    static let shared = SkillsBuilder()
    
    var skills: [Skill] = [
        OffensiveSkill(name: .flames, cost: 10, points: 50),
        OffensiveSkill(name: .thunder, cost: 20, points: 80),
        OffensiveSkill(name: .final, cost: 30, points: 100, range: 5),
        DefensiveSkill(name: .electrons, cost: 0, points: 100),
        DefensiveSkill(name: .immunity, cost: 10),
        DefensiveSkill(name: .current, cost: 10, points: 100)
    ]
    
    private init() { }
    
    func setup(_ manager: SkillsManager) {
        for skill in skills {
            manager.skills[skill.name] = skill
        }
    }

}
