//
//  Current.swift
//  NoahKit
//
//  Created by Franklin Fox on 6/3/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

public class Current: DefensiveSkill {

    public init() {
        super.init(name: SkillNames.Current.rawValue)
    }
    
    override func activate(target: Attackable?) {
        super.activate(nil)
        character.activateCurrent()
    }
    
}
