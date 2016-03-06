//
//  Final.swift
//  NoahKit
//
//  Created by Franklin Fox on 29/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

public class Final: OffensiveSkill {

    public init() {
        super.init(name: SkillNames.Final.rawValue)
    }
    
    override func activate(target: Attackable?) {
        super.activate(target)
        target?.activateFinal(300)
    }
    
}
