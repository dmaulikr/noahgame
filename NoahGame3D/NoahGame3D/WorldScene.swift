//
//  WorldScene.swift
//  NoahGame3D
//
//  Created by Franklin Fox on 2/3/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit
import SceneKit

class WorldScene: Scene {
    
    private static var instance : WorldScene? = nil
    
    var entities: [EntityView]
    var personage: PersonageView!
    var terrain: TerrainView
    
    static func sharedInstance() -> WorldScene {
        if instance == nil {
            instance = WorldScene()
        }
        
        return instance!
    }

    private override init() {
        entities = [EntityView]()
        terrain = TerrainView()
        super.init()
        
        self.setup()
    }
    
    override func setup() {
        super.setup()
        
        self.addEntity(terrain)
    }
    
    func addMainPersonage(personage: PersonageView) {
        self.personage = personage
        self.addEntity(personage)
        camera.addTarget(personage)
    }
    
    func addEntity(entity: EntityView) {
        entities.append(entity)
        self.addNode(entity.node)
    }
    
    func animate() {
        for entity in entities {
            entity.animate()
        }
    }
    
    func movePersonage(offsetX: Float, offsetY: Float) {
        personage.move(offsetX, offsetY: offsetY)
        camera.moveWithTarget()
    }
    
    func rotatePersonage(offset: Float) {
        personage.rotate(offset)
        camera.rotateWithTarget()
    }
    
    func activateSKillPersonage(index: Int) {
        personage.activateSkill(index)
    }
    
    func selectTargetNode(node: SCNNode) {
        let nodeName = node.name?.stringByReplacingOccurrencesOfString("Mesh", withString: "")
    
        for entity in entities {
            if entity.node.name == nodeName {
                personage.selectTarget(entity)
                return
            }
        }
        
        personage.deselectTarget()
    }
    
}
