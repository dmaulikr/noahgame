//
//  GameController.swift
//  NoahGame
//
//  Created by Technorides on 4/16/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    var pj1: UILabel!
    var messages = [Message]()
    
    var user: User? {
        didSet {
            navigationItem.title = user?.name
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendMessage()
        
        observeMessages()
        
        /*
        pj1 = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
        pj1.text = GameManager.shared.name1
        pj1.backgroundColor = .blue
        pj1.textAlignment = .center
        
        view.addSubview(pj1)
        
        GameManager.shared.delegate = self
        */
    }
    
    func observeMessages() {
        NoahService.shared.observeMessages { (message) in
            self.messages.append(message)
        }
    }

    func sendMessage() {
        let message = "Hello World!!!"
        
        if let toId = user?.id {
            NoahService.shared.sendMessage(message, toId: toId, completion: {
                print("didSendMessage")
            })
        }
    }
    
}

extension GameController: AttackableDelegate {
    
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
    }
    
    func updateStatus(_ health: Int, energy: Int) {
        print("pj h:\(health) e:\(energy)")
    }
    
    func updateLocation(_ location: Vector) {
        print("location x:\(location.x) y:\(location.y)")
        
        pj1.frame.origin = CGPoint(x: CGFloat(location.x),
                                   y: CGFloat(location.y))
    }
    
}


//GameManager.shared.createPersonage1(name: name1)
//GameManager.shared.createPersonage2(name: name2)

//performSegue(withIdentifier: "startSegue", sender: nil)
