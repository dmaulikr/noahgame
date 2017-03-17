//
//  PersonageView.swift
//  NoahGame3D
//
//  Created by Franklin Fox on 1/3/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import SceneKit
import NoahKit

class PersonageView: EntityView {
    
    var skills: [String]
    
    init(name: String!) {
        skills = [String]()
        super.init(entity: Personage(name: name), nodeName: "ship")
    
        NotificationCenter.default.addObserver(self, selector: "addSkill:", name: NSNotification.Name(rawValue: OperationNames.AddSkill.rawValue), object: nil)
        
        self.setup()
    }
    
    func setup() {
        let personage = entity as! Personage
        
        personage.addSkill(Electrons())
        personage.addSkill(Immunity())
        personage.addSkill(Current())
        personage.addSkill(Flames())
        personage.addSkill(Thunder())
        personage.addSkill(Final())
    }
    
    override func animate() {
        let action = SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1))
        node.runAction(action)
    }
    
    func move(_ offsetX: Float, offsetY: Float) {
        let personage = entity as! Personage
        
        offsetX < 0 ? personage.moveRight() : personage.moveLeft()
        
        offsetY < 0 ? personage.moveUp() : personage.moveDown()
        
        node.position = position
        print(node.position)
    }
    
    func rotate(_ offset: Float) {
        let personage = entity as! Personage
        
        offset < 0 ? personage.rotateLeft() : personage.rotateRight()
        
        node.eulerAngles.y = entity!.rotation
    }
    
    func activateSkill(_ index: Int) {
        let personage = entity as! Personage

        if index < skills.count {
            let skillName = skills[index]
            
            personage.activateSkill(skillName)
        }
    }
    
    var name: String {
        get {
            return (entity as! Personage).name
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
    
    var target: Attackable? {
        get {
            return (entity as! Personage).target
        }
    }
    
    func selectTarget(_ target: EntityView) {
        if target.entity is Attackable {
            let attackable = target.entity as! Attackable
            (entity as! Personage).selectTarget(attackable)
        } else {
            deselectTarget()
        }
    }
    
    func deselectTarget() {
        (entity as! Personage).deselectTarget()
    }
    
    func addSkill(_ notification: Notification) {
        let skill = notification.object as! Skill
        
        skills.append(skill.name)
    }
    
}
