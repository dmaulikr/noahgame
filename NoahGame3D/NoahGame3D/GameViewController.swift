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

class GameViewController: UIViewController {
    
    var worldScene: WorldScene!
    var currentMove: CGPoint!
    var currentRotate: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        worldScene = WorldScene.sharedInstance()
        
        // retrieve the character node
        let character = CharacterView()
        worldScene.addMainCharacter(character)
        
        // animate the 3d object
//        scene.animate()
        
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        worldScene.showInView(scnView)
        
        // add a tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: "handleTap:")
        scnView.addGestureRecognizer(tapGesture)
    }
    
    func handleTap(gestureRecognize: UIGestureRecognizer) {
        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // check what nodes are tapped
        let p = gestureRecognize.locationInView(scnView)
        let hitResults = scnView.hitTest(p, options: nil)
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result: AnyObject! = hitResults[0]
            
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
    
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        print("ended: \(event)")
//    }
    
    func move(lastLocation: CGPoint) {
        let offset = currentMove.y - lastLocation.y
        let vector = SCNVector3Make(0, 0, -Float(offset))
        
        worldScene.moveCharacter(vector)
        currentMove = lastLocation
    }
    
    func rotate(lastLocation: CGPoint) {
        let offset = currentRotate.x - lastLocation.x
        
        worldScene.rotateCharacter(Float(offset))
        currentRotate = lastLocation
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}
