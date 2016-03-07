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
    
    public var name: String!
    public var health, energy: Int
    var skills: SkillManager!
    
    public init(name: String!) {
        health = 200
        energy = 200
        super.init()
        
        self.name = name
        skills = SkillManager(personage: self)
        
        setup()
    }
    
    func setup() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "update", name: OperationNames.PersonageConnected.rawValue, object: nil)
    }
    
    func update() {
        Server.sharedInstance().personageConnected(self)
    }
    
    public func addSkill(skill: Skill) {
        skills.addSkill(skill)
    }
    
    public func activateSkill(name: String) {
        skills.activateSkill(name)
    }
    
    func debilityHealth(points: Int) {
        health -= points
        
        NSNotificationCenter.defaultCenter().postNotificationName(OperationNames.UpdatePersonage.rawValue, object: nil)
    }
    
    func debilityEnergy(points: Int) {
        energy -= points
        
        NSNotificationCenter.defaultCenter().postNotificationName(OperationNames.UpdatePersonage.rawValue, object: nil)
    }
    
    public func selectTarget(target: Attackable) {
        skills.target = target
        
        NSNotificationCenter.defaultCenter().postNotificationName(OperationNames.UpdateTarget.rawValue, object: nil)
    }
    
    public func deselectTarget() {
        skills.target = nil
        
        NSNotificationCenter.defaultCenter().postNotificationName(OperationNames.UpdateTarget.rawValue, object: nil)
    }
    
    public var target: Attackable? {
        get {
            return skills.target
        }
    }
    
    // MARK: Buffable
    public func activateElectrons(points: Int) {
        debilityEnergy(-points)
    }
    
    public func activateImmunity() { }
    
    public func activateCurrent() { }
    
    // MARK: Attackable
    public func activateFlames(points: Int) {
        debilityHealth(points)
    }

    public func activateThunder(points: Int) {
        debilityHealth(points)
    }

    public func activateFinal(points: Int) {
        debilityHealth(points)
    }
    
    // MARK: Movable
    public func moveUp() {
        position.move(Vector.up, angle: rotation)
    }
    
    public func moveDown() {
        position.move(Vector.down, angle: rotation)
    }
    
    public func moveRight() {
        position.move(Vector.right, angle: rotation)
    }
    
    public func moveLeft() {
        position.move(Vector.left, angle: rotation)
    }
    
    public func rotateRight() {
        rotation += 1 / 10
    }

    public func rotateLeft() {
        rotation -= 1 / 10
    }
}
