//
//  WorldScene.swift
//  NoahGame3D
//
//  Created by Franklin Fox on 2/3/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

class WorldScene: Scene {
    
    private static var instance : WorldScene? = nil
    
    var entities: [EntityView]
    var character: CharacterView!
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
    
    func addMainCharacter(character: CharacterView) {
        self.character = character
        self.addEntity(character)
        camera.addTarget(character)
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
}
