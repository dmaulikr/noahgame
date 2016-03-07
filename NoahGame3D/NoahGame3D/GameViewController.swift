//
//  GameViewController.swift
//  NoahGame3D
//
//  Created by Franklin Fox on 1/3/16.
//  Copyright (c) 2016 FoxDev. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import NoahKit

class GameViewController: UIViewController {

    @IBOutlet weak var sceneView: SCNView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var health: UILabel!
    @IBOutlet weak var energy: UILabel!
    @IBOutlet weak var targetName: UILabel!
    @IBOutlet weak var targetHealth: UILabel!
    @IBOutlet weak var targetEnergy: UILabel!
    @IBOutlet var skills: [UIButton]!
    
    var userName: String!
    
    var worldScene: WorldScene!
    var currentMove: CGPoint!
    var currentRotate: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Server.sharedInstance().connect()
        
        worldScene = WorldScene.sharedInstance()
        
        let personage = PersonageView(name: userName)
        worldScene.addMainPersonage(personage)
        
        // animate the 3d object
//        scene.animate()
        
        worldScene.showInView(sceneView)
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: "handleTap:")
        sceneView.addGestureRecognizer(tapGesture)
        
        setup()
    }
    
    func setup() {
        name.text = worldScene.personage.name
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateHealthAndEnergy", name: OperationNames.UpdatePersonage.rawValue, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "selectTarget", name: OperationNames.SelectTarget.rawValue, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        updateHealthAndEnergy()
        updateSkillsBar()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        Server.sharedInstance().disconnect()
    }
    
    func handleTap(gestureRecognize: UIGestureRecognizer) {
        // check what nodes are tapped
        let p = gestureRecognize.locationInView(sceneView)
        let hitResults = sceneView.hitTest(p, options: nil)
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result: AnyObject! = hitResults[0]
            
            // select target
            worldScene.selectTargetNode(result.node!)
            
            // get its material
            let material = result.node!.geometry!.firstMaterial!
            
            // highlight it
            SCNTransaction.begin()
            SCNTransaction.setAnimationDuration(0.5)
            
            // on completion - unhighlight
            SCNTransaction.setCompletionBlock {
                SCNTransaction.begin()
                SCNTransaction.setAnimationDuration(0.5)
                
                material.emission.contents = UIColor.blackColor()
                
                SCNTransaction.commit()
            }
            
            material.emission.contents = UIColor.redColor()
            
            SCNTransaction.commit()
        }
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let screenSize = UIScreen.mainScreen().bounds
        
        for touch in touches {
            let lastLocation = touch.locationInView(self.view)
            
            if lastLocation.x < screenSize.size.width / 2 {
                currentMove = lastLocation
            } else {
                currentRotate = lastLocation
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let screenSize = UIScreen.mainScreen().bounds
        
        for touch in touches {
            let lastLocation = touch.locationInView(self.view)
        
            if lastLocation.x < screenSize.size.width / 2 {
                self.move(lastLocation)
            } else {
                self.rotate(lastLocation)
            }
        }
    }
    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) { }
    
    func move(lastLocation: CGPoint) {
        let offsetX = currentMove.x - lastLocation.x
        let offsetY = currentMove.y - lastLocation.y
              
        worldScene.movePersonage(Float(offsetX), offsetY: Float(offsetY))
        currentMove = lastLocation
    }
    
    func rotate(lastLocation: CGPoint) {
        let offset = currentRotate.x - lastLocation.x
        
        worldScene.rotatePersonage(Float(offset))
        currentRotate = lastLocation
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    @IBAction func activeSkill(sender: AnyObject) {
        let button = sender as! UIButton
        let index = skills.indexOf(button)
        
        worldScene.activateSKillPersonage(index!)
        updateHealthAndEnergy()
    }
    
    func updateHealthAndEnergy() {
        let personage = worldScene.personage
        
        health.text = String(personage.health)
        energy.text = String(personage.energy)
    }
    
    func updateSkillsBar() {
        let personage = worldScene.personage
        
        for button in skills {
            let index = skills.indexOf(button)
            let name = personage.skills[index!]
            
            button.setTitle(name, forState: UIControlState.Normal)
        }
    }
    
    func selectTarget() {
        let target = worldScene.personage.target
        
        targetName.text = target?.name
        targetHealth.text = target?.health != nil ? String(target?.health) : ""
        targetEnergy.text = target?.energy != nil ? String(target?.energy) : ""
    }
}
