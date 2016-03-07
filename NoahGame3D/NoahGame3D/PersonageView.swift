//
//  PersonageView.swift
//  NoahGame3D
//
//  Created by Franklin Fox on 1/3/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import SceneKit
import NoahKit

class CharacterView: EntityView {
    
    var skills: [String]
    
    override init() {
        skills = [String]()
        super.init(entity: Personage(name: "Personage"), nodeName: "ship")
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "addSkill:", name: "characterAddSkill", object: nil)
        
        self.setup()
    }
    
    func setup() {
        let character = entity as! Personage
        
        character.addSkill(Electrons())
        character.addSkill(Immunity())
        character.addSkill(Current())
        character.addSkill(Flames())
        character.addSkill(Thunder())
        character.addSkill(Final())
    }
    
    override func animate() {
        let action = SCNAction.repeatActionForever(SCNAction.rotateByX(0, y: 2, z: 0, duration: 1))
        node.runAction(action)
    }
    
    func move(offsetX: Float, offsetY: Float) {
        let character = entity as! Personage
        
        offsetX < 0 ? character.moveRight() : character.moveLeft()
        
        offsetY < 0 ? character.moveUp() : character.moveDown()
        
        node.position = position
        print(node.position)
    }
    
    func rotate(offset: Float) {
        let character = entity as! Personage
        
        offset < 0 ? character.rotateLeft() : character.rotateRight()
        
        node.eulerAngles.y = entity!.rotation
    }
    
    func activateSkill(index: Int) {
        let character = entity as! Personage

        if index < skills.count {
            let skillName = skills[index]
            
            character.activateSkill(skillName)
        }
    }
    
    var health: Int {
        get {
            return (entity as! Personage).health
        }
    }
    
    var energy: Int {
        get {
            return (entity as! Personage).energy
        }
    }
    
    // MARK: Observers
    func addSkill(notification: NSNotification) {
        let skill = notification.object as! Skill
        
        skills.append(skill.name)
    }
    
}
