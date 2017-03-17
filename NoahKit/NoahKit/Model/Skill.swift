//
//  Skill.swift
//  NoahKit
//
//  Created by Franklin Fox on 28/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

open class Skill: NSObject {

//    protected IAttackCharacter character;
//    private string name;
//    private int level, reload, duration, currentReload, currentDuration;
//    private int cost;
    
    open var name: String!
    var personage: Buffable!

    init(name: String) {
        super.init()
        self.name = name
    }
    
    func activateSkill(_ target: Attackable?) {
        Server.sharedInstance().activateSkill(personage: personage, skill: self, target: target)
    }
    
    func activate(_ target: Attackable?) { }
    
}
