//
//  Final.swift
//  NoahKit
//
//  Created by Franklin Fox on 29/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

class Final: OffensiveSkill {

    init() {
        super.init(name: SkillNames.Final.rawValue)
    }
    
    override func activate(target: Attackable?) {
        target?.activateFinal(300)
    }
    
}
