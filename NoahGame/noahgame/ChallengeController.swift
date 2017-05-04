
//  ChallengeController.swift
//  NoahGame
//
//  Created by Technorides on 4/16/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

import UIKit
import CoreMotion

class ChallengeController: UIViewController {
    
    @IBOutlet var username1: UILabel!
    @IBOutlet var username2: UILabel!
    @IBOutlet var skills: [UIButton]!
    
    var messages = [Message]()
    var challenge: Challenge?
    
    var personage: Personage? {
        didSet {
            navigationItem.title = personage?.name
        }
    }
    
    var enemy: Personage?
    
    var motionManager = CMMotionManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpPersonages()
        createChallenge()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        motionManager.gyroUpdateInterval = 0.2
        
        motionManager.startGyroUpdates(to: OperationQueue.current!) { (data, error) in
            
            if let rotation = data?.rotationRate {
                //print(rotation)
                
                if rotation.x > 1 {
                    print("DOWN")
                }
                if rotation.x < -1 {
                    print("UP")
                }
                
                if rotation.y > 1 {
                    print("RIGHT")
                }
                if rotation.y < -1 {
                    print("LEFT")
                }
            }
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        motionManager.stopGyroUpdates()
    }
    
    func setUpPersonages() {
        if let pj1 = personage, let pj2 = enemy {
            username1.text = "\(pj1.name) h:\(pj1.health) e:\(pj1.energy)"
            username2.text = "\(pj2.name) h:\(pj2.health) e:\(pj2.energy)"
        }
    }
    
    func createChallenge() {
        if let pj1 = personage, let pj2 = enemy {
            let challenge = Challenge(personage: pj1, enemy: pj2)
        
            NoahService.shared.createChallenge(challenge) { id in
                self.challenge = challenge
                self.challenge?.id = id
            
                NoahService.shared.observeSkills(challengeId: id) { skillname in
                    print("receive skillname: \(skillname)")
                }

            }
        }
    }
    
    @IBAction func activateSkill(_ sender: UIButton) {
        
        let index = skills.index(of: sender) ?? 0
        var skillName: SkillName
        
        switch index {
        case 1:
            skillName = .thunder
        case 2:
            skillName = .final
        case 3:
            skillName = .electrons
        case 4:
            skillName = .immunity
        case 5:
            skillName = .current
        default:
            skillName = .flames
        }
        
        let target = GameManager.shared.pj2
        GameManager.shared.pj1.activateSkill(skillName, target: target)
        
        NoahService.shared.activateSkill(skillName.rawValue, challengeId: challenge!.id!) { message in
            print("activé la skill: \(message)")
        }
        
    }

    func sendMessage() {
//        let message = "Hello World!!!"
        
//        if let toId = user?.id {
//            NoahService.shared.sendMessage(message, toId: toId) {
//                print("didSendMessage")
//            }
//        }
    }
    
}

extension ChallengeController: AttackableDelegate {
    
    /*
    @IBAction func didUp(_ sender: Any) {
        GameManager.shared.movePersonage1(direction: .left)
    }
    
    @IBAction func didLeft(_ sender: Any) {
        GameManager.shared.movePersonage1(direction: .down)
    }
    
    @IBAction func didRight(_ sender: Any) {
        GameManager.shared.movePersonage1(direction: .up)
    }
    
    @IBAction func didDown(_ sender: Any) {
        GameManager.shared.movePersonage1(direction: .right)
    }*/
    
    func updateStatus(_ health: Int, energy: Int) {
        print("pj h:\(health) e:\(energy)")
    }
    
    func updateLocation(_ location: Vector) {
        print("location x:\(location.x) y:\(location.y)")
        
        //pj1.frame.origin = CGPoint(x: CGFloat(location.x), y: CGFloat(location.y))
    }
    
}
