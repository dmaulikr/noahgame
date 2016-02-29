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
    
    override func setUp() {
        super.setUp()
        let skill1 = DefensiveSkill(name: "DefensiveSkill")
        let skill2 = OffensiveSkill(name: "OffensiveSkill")
        
        character = Character(name: "Character")
        character.addSkill(skill1)
        character.addSkill(skill2)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testActivateDefensiveSkill() {
        let energy = character.energy
        character.activateSkill("DefensiveSkill")
        
        XCTAssertEqual(character.energy, energy + 100)
    }
    
    func testActivateOffensiveSkill() {
        let enemy = Character(name: "Enemy")
        let health = enemy.health
        
        character.selectTarget(enemy)
        character.activateSkill("OffensiveSkill")
        
        XCTAssertEqual(enemy.health, health - 100)
    }
    
}
