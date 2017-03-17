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

    let scene: SCNScene!
    var camera: Camera
    
    override init() {
        scene = SCNScene(named: "art.scnassets/ship.scn")!
        scene.physicsWorld.speed = 3
        camera = Camera()
        super.init()
        
        self.addLights()
    }
    
    func setup() {
        self.addNode(camera.orbit)
    }
    
    func addLights() {
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLight.LightType.omni
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        self.addNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLight.LightType.ambient
        ambientLightNode.light!.color = UIColor.darkGray
        self.addNode(ambientLightNode)
    }
    
    func addNode(_ node: SCNNode) {
        scene.rootNode.addChildNode(node)
    }
    
    func getEntityWithName(_ name: String) -> SCNNode {
        return scene.rootNode.childNode(withName: name, recursively: true)!
    }
    
    func showInView(_ view: SCNView) {
        view.scene = scene
//        view.allowsCameraControl = true
        view.showsStatistics = true
        view.backgroundColor = UIColor.black
    }
    
}
