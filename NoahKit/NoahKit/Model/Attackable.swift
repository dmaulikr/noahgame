//
//  Attackable.swift
//  NoahKit
//
//  Created by Franklin Fox on 28/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

public protocol Attackable: PersonageProtocol {

//    bool IsNormal(IAttackCharacter character);
//    bool IsNear(IAttackCharacter character);
//    bool ChanceResistance(ISkill skill, IAttackCharacter character);
//    void Debility(int damage, ISkill skill, IAttackCharacter enemy);
//    void DebilityCritical(int damage, ISkill skill, IAttackCharacter enemy);
//    void DebilityEnergy(int damage);
//    string Name { get; }
    
    func activateFlames(_ points: Int)
    func activateThunder(_ points: Int)
    func activateFinal(_ pointss: Int)
    
}
