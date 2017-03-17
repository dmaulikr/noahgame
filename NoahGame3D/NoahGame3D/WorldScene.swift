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
    
    fileprivate static var instance : WorldScene? = nil
    
    var entities: [EntityView]
    var personage: PersonageView!
    var terrain: TerrainView
    
    static func sharedInstance() -> WorldScene {
        if instance == nil {
            instance = WorldScene()
        }
        
        return instance!
    }

    fileprivate override init() {
        entities = [EntityView]()
        terrain = TerrainView()
        super.init()
        
        self.setup()
    }
    
    override func setup() {
        super.setup()
        
        self.addEntity(terrain)
    }
    
    func addMainPersonage(_ personage: PersonageView) {
        self.personage = personage
        self.addEntity(personage)
        camera.addTarget(personage)
    }
    
    func addEntity(_ entity: EntityView) {
        entities.append(entity)
        self.addNode(entity.node)
    }
    
    func animate() {
        for entity in entities {
            entity.animate()
        }
    }
    
    func movePersonage(_ offsetX: Float, offsetY: Float) {
        personage.move(offsetX, offsetY: offsetY)
        camera.moveWithTarget()
    }
    
    func rotatePersonage(_ offset: Float) {
        personage.rotate(offset)
        camera.rotateWithTarget()
    }
    
    func activateSKillPersonage(_ index: Int) {
        personage.activateSkill(index)
    }
    
    func selectTargetNode(_ node: SCNNode) {
        let nodeName = node.name?.replacingOccurrences(of: "Mesh", with: "")
    
        for entity in entities {
            if entity.node.name == nodeName {
                personage.selectTarget(entity)
                return
            }
        }
        
        personage.deselectTarget()
    }
    
}
