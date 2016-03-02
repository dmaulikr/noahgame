//
//  Character.swift
//  NoahKit
//
//  Created by Franklin Fox on 28/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

public class Character: Entity, Buffable, Attackable, Movable {

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
    
    var rotation : Float = 0
    
    public init(name: String!) {
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
    
    // MARK: Attackable
    public func activateFlames(damage: Int) {
        self.debilityHealth(damage)
    }

    public func activateThunder(damage: Int) {
        self.debilityHealth(damage)
    }

    public func activateFinal(damage: Int) {
        self.debilityHealth(damage)
    }
    
    // MARK: Movable
    internal func moveUp() {
        position.move(Vector.up, angle: rotation)
    }
    
    internal func moveDown() {
        position.move(Vector.down, angle: rotation)
    }
    
    internal func moveRight() {
        position.move(Vector.right, angle: rotation)
    }
    
    internal func moveLeft() {
        position.move(Vector.left, angle: rotation)
    }
    
    public func rotateRight() {
        rotation += 1
    }

    public func rotateLeft() {
        rotation -= 1
    }
}
