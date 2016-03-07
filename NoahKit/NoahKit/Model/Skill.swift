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
    
    public var name: String
    var personage: Buffable!

    init(name: String) {
        self.name = name
    }
    
    func activate(target: Attackable?) {
        print(name)
        Server.sharedInstance().activateSkill(personage, skill: self, target: target)
    }
    
}
