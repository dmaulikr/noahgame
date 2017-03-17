//
//  Personage.swift
//  NoahKit
//
//  Created by Franklin Fox on 28/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

open class Personage: Entity, Buffable, Attackable, Movable {

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
    
    open var name: String!
    open var health, energy: Int
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
        NotificationCenter.default.addObserver(self, selector: #selector(Personage.update), name: NSNotification.Name(rawValue: OperationNames.PersonageConnected.rawValue), object: nil)
    }
    
    func update() {
        Server.sharedInstance().personageConnected(personage: self)
    }
    
    open func addSkill(_ skill: Skill) {
        skills.addSkill(skill)
    }
    
    open func activateSkill(_ name: String) {
        skills.activateSkill(name)
    }
    
    func debilityHealth(_ points: Int) {
        health -= points
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: OperationNames.UpdatePersonage.rawValue), object: nil)
    }
    
    func debilityEnergy(_ points: Int) {
        energy -= points
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: OperationNames.UpdatePersonage.rawValue), object: nil)
    }
    
    open func selectTarget(_ target: Attackable) {
        skills.target = target
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: OperationNames.UpdateTarget.rawValue), object: nil)
    }
    
    open func deselectTarget() {
        skills.target = nil
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: OperationNames.UpdateTarget.rawValue), object: nil)
    }
    
    open var target: Attackable? {
        get {
            return skills.target
        }
    }
    
    // MARK: Buffable
    open func activateElectrons(_ points: Int) {
        debilityEnergy(-points)
    }
    
    open func activateImmunity() { }
    
    open func activateCurrent() { }
    
    // MARK: Attackable
    open func activateFlames(_ points: Int) {
        debilityHealth(points)
    }

    open func activateThunder(_ points: Int) {
        debilityHealth(points)
    }

    open func activateFinal(_ points: Int) {
        debilityHealth(points)
    }
    
    // MARK: Movable
    open func moveUp() {
        position.move(Vector.up, angle: rotation)
    }
    
    open func moveDown() {
        position.move(Vector.down, angle: rotation)
    }
    
    open func moveRight() {
        position.move(Vector.right, angle: rotation)
    }
    
    open func moveLeft() {
        position.move(Vector.left, angle: rotation)
    }
    
    open func rotateRight() {
        rotation += 1 / 10
    }

    open func rotateLeft() {
        rotation -= 1 / 10
    }
}
