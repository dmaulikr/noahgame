//
//  Attackable.swift
//  NoahKit
//
//  Created by Franklin Fox on 28/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

protocol Attackable: Movable {
    
    var name: String { get }
    var level: Int { get }
    var health: Int { get }
    var energy: Int { get }
    var delegate: AttackableDelegate? { get set }
    
    func activateSkill(_ name: SkillName, target: Attackable)
    func consumeEnergy(_ skill: Skill)
    func isNear(_ localizable: Localizable, range: Float) -> Bool
    
    func receiveOffensiveSkill(_ skill: OffensiveSkill)
    
}

protocol Buffable: Attackable {
 
    func receiveDefensiveSkill(_ skill: DefensiveSkill)
    
}

public protocol AttackableDelegate {
    
    func updateStatus(_ health: Int, energy: Int)
    func updateLocation(_ location: Vector)
    
}

//    bool IsNormal(IAttackCharacter character);
//    bool IsNear(IAttackCharacter character);
//    bool ChanceResistance(ISkill skill, IAttackCharacter character);
//    void Debility(int damage, ISkill skill, IAttackCharacter enemy);
//    void DebilityCritical(int damage, ISkill skill, IAttackCharacter enemy);
//    void DebilityEnergy(int damage);
//    string Name { get; }
