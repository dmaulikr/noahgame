//
//  GameManager.swift
//  NoahKit
//
//  Created by Technorides on 4/16/17.
//  Copyright © 2017 FoxDev. All rights reserved.
//

class GameManager {
    
    static let shared = GameManager()
    var pj1, pj2: Attackable
    
    var name1: String {
        get { return pj1.name }
    }
    
    var name2: String {
        get { return pj2.name }
    }
    
    var delegate: AttackableDelegate? {
        get { return nil }
        set { pj1.delegate = newValue }
    }
    
    
    private init() {
        pj1 = Personage(name: "PJ1", health: 200, energy: 200)
        pj2 = Personage(name: "PJ2", health: 200, energy: 200)
        
        pj1.activateSkill(.flames, target: pj2)
        pj1.activateSkill(.final, target: pj2)
        pj2.activateSkill(.electrons, target: pj1)
        
        print("pj1 h:\(pj1.health) e:\(pj1.energy)")
        print("pj2 h:\(pj2.health) e:\(pj2.energy)")
    }
    
    func createPersonage1(name: String) {
        pj1 = Personage(name: name, health: 200, energy: 200)
    }
    
    func createPersonage2(name: String) {
        pj2 = Personage(name: name, health: 200, energy: 200)
    }
    
    func movePersonage1(direction: Vector) {
        pj1.move(direction)
    }
    
}
