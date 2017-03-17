//
//  Electrons.swift
//  NoahKit
//
//  Created by Franklin Fox on 29/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

open class Electrons: DefensiveSkill {

    public init() {
        super.init(name: SkillNames.Electrons.rawValue)
    }
    
    override func activate(_ target: Attackable?) {
        super.activate(nil)
        personage.activateElectrons(100)
    }
    
}
