//
//  CharacterTests.swift
//  NoahKit
//
//  Created by Franklin Fox on 28/2/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import XCTest

class CharacterTests: XCTestCase {

    var character : Character!
    var enemy : Character!
    
    override func setUp() {
        super.setUp()
        
        character = Character(name: "Character")
        character.addSkill(Electrons())
        character.addSkill(Flames())
        character.addSkill(Thunder())
        character.addSkill(Final())
        
        enemy = Character(name: "Enemy")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // Defensive Skills
    func testActivateElectronsSkill() {
        let energy = character.energy
        character.activateSkill(SkillNames.Electrons.rawValue)
        
        XCTAssertEqual(character.energy, energy + 100)
    }
    
    // Offensive Skills
    func testActivateFlamesSkill() {
        let health = enemy.health
        
        character.selectTarget(enemy)
        character.activateSkill(SkillNames.Flames.rawValue)
        
        XCTAssertEqual(enemy.health, health - 100)
    }
    
    func testActivateThunderSkill() {
        let health = enemy.health
        
        character.selectTarget(enemy)
        character.activateSkill(SkillNames.Thunder.rawValue)
        
        XCTAssertEqual(enemy.health, health - 200)
    }
    
    func testActivateFinalSkill() {
        let health = enemy.health
        
        character.selectTarget(enemy)
        character.activateSkill(SkillNames.Final.rawValue)
        
        XCTAssertEqual(enemy.health, health - 300)
    }
    
    func testSkillNames() {
        let skill = Electrons()
        
        XCTAssertEqual(skill.name, SkillNames.Electrons.rawValue)
    }
}
