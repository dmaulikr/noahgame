////
////  PersonageTests.swift
////  NoahKit
////
////  Created by Franklin Fox on 28/2/16.
////  Copyright © 2016 FoxDev. All rights reserved.
////
//
//import XCTest
//
//class PersonageTests: XCTestCase {
//
//    var personage: Personage!
//    var enemy: Personage!
//    
//    override func setUp() {
//        super.setUp()
//        
//        personage = Personage(name: "Personage")
//        personage.addSkill(Electrons())
//        personage.addSkill(Flames())
//        personage.addSkill(Thunder())
//        personage.addSkill(Final())
//        
//        enemy = Personage(name: "Enemy")
//    }
//    
//    override func tearDown() {
//        super.tearDown()
//    }
//    
//    // Defensive Skills
//    func testActivateElectronsSkill() {
//        let energy = personage.energy
//        personage.activateSkill(SkillNames.Electrons.rawValue)
//        
//        XCTAssertEqual(personage.energy, energy + 100)
//    }
//    
//    // Offensive Skills
//    func testActivateFlamesSkill() {
//        let health = enemy.health
//        
//        personage.selectTarget(enemy)
//        personage.activateSkill(SkillNames.Flames.rawValue)
//        
//        XCTAssertEqual(enemy.health, health - 100)
//    }
//    
//    func testActivateThunderSkill() {
//        let health = enemy.health
//        
//        personage.selectTarget(enemy)
//        personage.activateSkill(SkillNames.Thunder.rawValue)
//        
//        XCTAssertEqual(enemy.health, health - 200)
//    }
//    
//    func testActivateFinalSkill() {
//        let health = enemy.health
//        
//        personage.selectTarget(enemy)
//        personage.activateSkill(SkillNames.Final.rawValue)
//        
//        XCTAssertEqual(enemy.health, health - 300)
//    }
//    
//    func testSkillNames() {
//        let skill = Electrons()
//        
//        XCTAssertEqual(skill.name, SkillNames.Electrons.rawValue)
//    }
//
//    func testMovePersonage() {
//        personage.moveUp()
//        
//        XCTAssertEqual(personage.position.x, 1)
//        XCTAssertEqual(personage.position.y, 0)
//    }
//
//    func testSumeVectors() {
//        let vector = Vector(x: 1, y: 1)
//        vector.sume(Vector.up)
//        
//        XCTAssertEqual(vector.x, 1)
//        XCTAssertEqual(vector.y, 2)
//    }
//    
//    func testMagnitudeVector() {
//        let vector = Vector(x: 3, y: 4)
//        
//        XCTAssertEqual(vector.magnitude(), 5)
//    }
//    
//    func testMoveUpVector() {
//        let vector = Vector.zero
//        vector.move(Vector.up, angle: 0) // angle in X direction
//        
//        XCTAssertEqual(vector.x, 1)
//        XCTAssertEqual(Int(vector.y), 0)
//    }
//    
//    func testMoveDownVector() {
//        let vector = Vector.zero
//        vector.move(Vector.down, angle: 0) // angle in X direction
//        
//        XCTAssertEqual(vector.x, -1)
//        XCTAssertEqual(Int(vector.y), 0)
//    }
//    
//    func testMoveRightVector() {
//        let vector = Vector.zero
//        vector.move(Vector.right, angle: 0) // angle in X direction
//        
//        XCTAssertEqual(Int(vector.x), 0)
//        XCTAssertEqual(vector.y, 1)
//    }
//    
//    func testMoveLeftVector() {
//        let vector = Vector.zero
//        vector.move(Vector.left, angle: 0) // angle in X direction
//        
//        XCTAssertEqual(Int(vector.x), 0)
//        XCTAssertEqual(vector.y, -1)
//    }
//    
//}
