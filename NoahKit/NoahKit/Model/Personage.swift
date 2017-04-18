//
//  Personage.swift
//  NoahKit
//
//  Created by Franklin Fox on 28/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

class Personage: GameEntity {
    
    var name: String
    var health, energy: Int
    var level: Int
    var delegate: AttackableDelegate?
    lazy var skills: SkillsManager = SkillsManager(personage: self)
    

    init(name: String, health: Int, energy: Int) {
        self.name = name
        self.health = health
        self.energy = energy
        level = 1
    }
    
    func addSkill(_ skill: Skill) {
        skills.addSkill(skill)
    }
    
    func debilityHealth(_ points: Int) {
        health -= points
        
        delegate?.updateStatus(health, energy: energy)
    }
    
    func debilityEnergy(_ points: Int) {
        energy -= points
        
        delegate?.updateStatus(health, energy: energy)
    }
    
}

extension Personage: Buffable {
    
    func activateSkill(_ name: SkillName, target: Attackable) {
        skills.activateSkill(name, target: target)
    }
    
    func consumeEnergy(_ skill: Skill) {
        debilityEnergy(skill.cost)
    }
    
    func isNear(_ localizable: Localizable, range: Float) -> Bool {
        let distance = position - localizable.position
        
        return distance.magnitude() <= range
    }
    
    func receiveOffensiveSkill(_ skill: OffensiveSkill) {
        debilityHealth(skill.points)
    }
    
    func receiveDefensiveSkill(_ skill: DefensiveSkill) { }
    
}

extension Personage: Movable {
    
    func move(_ direction: Vector) {
        position.move(direction, angle: rotation)
        
        delegate?.updateLocation(position)
    }
    
    func rotateRight() {
        rotation += 1 / 10
    }
    
    func rotateLeft() {
        rotation -= 1 / 10
    }
    
}

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
