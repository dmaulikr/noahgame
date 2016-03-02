//
//  Scene.swift
//  NoahGame3D
//
//  Created by Franklin Fox on 1/3/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit
import SceneKit

class Scene: NSObject {

    let scene : SCNScene!
    var camera : Camera
    
    override init() {
        scene = SCNScene(named: "art.scnassets/ship.scn")!
        scene.physicsWorld.speed = 3
        camera = Camera()
        super.init()
        
        self.addLights()
    }
    
    func setup() {
        self.addNode(camera.node)
    }
    
    func addLights() {
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLightTypeOmni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        self.addNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLightTypeAmbient
        ambientLightNode.light!.color = UIColor.darkGrayColor()
        self.addNode(ambientLightNode)
    }
    
    func addNode(node: SCNNode) {
        scene.rootNode.addChildNode(node)
    }
    
    func getEntityWithName(name: String) -> SCNNode {
        return scene.rootNode.childNodeWithName(name, recursively: true)!
    }
    
    func showInView(view: SCNView) {
        view.scene = scene
        view.allowsCameraControl = true
        view.showsStatistics = true
        view.backgroundColor = UIColor.blackColor()
    }
    
}
