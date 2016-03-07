//
//  Skill.swift
//  NoahKit
//
//  Created by Franklin Fox on 28/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

public class Skill: NSObject {

//    protected IAttackCharacter character;
//    private string name;
//    private int level, reload, duration, currentReload, currentDuration;
//    private int cost;
    
    public var name: String!
    var personage: Buffable!

    init(name: String) {
        super.init()
        self.name = name
    }
    
    func activateSkill(target: Attackable?) {
        Server.sharedInstance().activateSkill(personage, skill: self, target: target)
    }
    
    func activate(target: Attackable?) { }
    
}
