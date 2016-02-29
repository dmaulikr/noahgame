//
//  Character.swift
//  NoahKit
//
//  Created by Franklin Fox on 28/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

public class Character: NSObject, Attackable {

//    Entity
//    protected string name;
//    protected Vector position;
    
//    Character
//    protected bool move;  //detect collisions
//    private float rotate;

//    AttackCharacter
//    protected int level;
//    protected int health, energy;
//    protected State state;
//    protected SkillsList skills;
//    
//    protected bool attack;
//    private Time speedyReload, second;
    
//    Personage
//    private int force, valor, temper, speedy;
//    private int bonusForce, bonusValue, bonusArmor, bonusResistance;
//    
//    private int battlesWon, battlesPlay;
//    private long totalExperience, goldCoins;
//    protected ItemsList items;
//    protected Equipment equipment;
    
    var name : String!
    internal var health, energy : Int
    var skills : SkillManager!
    
    internal init(name: String!) {
        health = 0
        energy = 0
        super.init()
        
        self.name = name
        skills = SkillManager(character: self)
    }
    
    internal func addSkill(skill: Skill) {
        skills.addSkill(skill)
    }
    
    internal func activateSkill(name: String) {
        skills.activateSkill(name)
    }
    
    func activateMeditation(points: Int) {
        energy += points
    }
    
    func selectTarget(target: Character?) {
        skills.selectTarget(target)
    }
    
    // MARK:
    public func activateCourt(damage: Int) {
        health -= damage
    }
    
}
