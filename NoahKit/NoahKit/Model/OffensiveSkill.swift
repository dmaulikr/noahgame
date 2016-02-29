//
//  OffensiveSkill.swift
//  NoahKit
//
//  Created by Franklin Fox on 28/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

class OffensiveSkill: Skill {

    override init(name: String!) {
        super.init(name: name)
    }
    
    override func activate(target: Attackable?) {
        target?.activateCourt(100)
    }
}
