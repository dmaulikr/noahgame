//
//  Flames.swift
//  NoahKit
//
//  Created by Franklin Fox on 29/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

public class Flames: OffensiveSkill {

    public init() {
        super.init(name: SkillNames.Flames.rawValue)
    }
    
    override func activate(target: Attackable?) {
        super.activate(target)
        target?.activateFlames(100)
    }
    
}
