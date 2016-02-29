//
//  Attackable.swift
//  NoahKit
//
//  Created by Franklin Fox on 28/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

public protocol Attackable {

//    bool IsNormal(IAttackCharacter character);
//    bool IsNear(IAttackCharacter character);
//    bool ChanceResistance(ISkill skill, IAttackCharacter character);
//    void Debility(int damage, ISkill skill, IAttackCharacter enemy);
//    void DebilityCritical(int damage, ISkill skill, IAttackCharacter enemy);
//    void DebilityEnergy(int damage);
//    string Name { get; }
    
    func activateFlames(damage: Int)
    func activateThunder(damage: Int)
    func activateFinal(damage: Int)
    
}
