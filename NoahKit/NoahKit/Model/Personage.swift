//
//  Personage.swift
//  NoahKit
//
//  Created by Franklin Fox on 28/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

public class Personage: Entity, Buffable, Attackable, Movable {

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
    
    var name: String!
    public var health, energy: Int
    var skills: SkillManager!
    
    public init(name: String!) {
        health = 200
        energy = 200
        super.init()
        
        self.name = name
        skills = SkillManager(personage: self)
    }
    
    public func addSkill(skill: Skill) {
        skills.addSkill(skill)
    }
    
    public func activateSkill(name: String) {
        skills.activateSkill(name)
    }
    
    func debilityHealth(damage: Int) {
        health -= damage
    }
    
    func selectTarget(target: Attackable?) {
        skills.target = target
    }
    
    // MARK: Buffable
    public func activateElectrons(points: Int) {
        energy += points
    }
    
    public func activateImmunity() { }
    
    public func activateCurrent() { }
    
    // MARK: Attackable
    public func activateFlames(damage: Int) {
        debilityHealth(damage)
    }

    public func activateThunder(damage: Int) {
        debilityHealth(damage)
    }

    public func activateFinal(damage: Int) {
        debilityHealth(damage)
    }
    
    // MARK: Movable
    public func moveUp() {
        self.position.move(Vector.up, angle: self.rotation)
    }
    
    public func moveDown() {
        self.position.move(Vector.down, angle: self.rotation)
    }
    
    public func moveRight() {
        self.position.move(Vector.right, angle: self.rotation)
    }
    
    public func moveLeft() {
        self.position.move(Vector.left, angle: self.rotation)
    }
    
    public func rotateRight() {
        self.rotation += 1 / 10
    }

    public func rotateLeft() {
        self.rotation -= 1 / 10
    }
}
