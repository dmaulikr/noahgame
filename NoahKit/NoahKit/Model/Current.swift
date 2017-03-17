//
//  Current.swift
//  NoahKit
//
//  Created by Franklin Fox on 6/3/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

open class Current: DefensiveSkill {

    public init() {
        super.init(name: SkillNames.Current.rawValue)
    }
    
    override func activate(_ target: Attackable?) {
        super.activate(nil)
        personage.activateCurrent()
    }
    
}
