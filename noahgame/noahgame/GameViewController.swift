//
//  GameViewController.swift
//  NoahGame
//
//  Created by Technorides on 4/16/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var pj1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pj1 = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
        pj1.text = GameManager.shared.name1
        pj1.backgroundColor = .blue
        pj1.textAlignment = .center
        
        view.addSubview(pj1)
        
        GameManager.shared.delegate = self
    }

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
    
}

extension GameViewController: AttackableDelegate {
    
    func updateStatus(_ health: Int, energy: Int) {
        print("pj h:\(health) e:\(energy)")
    }
    
    func updateLocation(_ location: Vector) {
        print("location x:\(location.x) y:\(location.y)")
        
        pj1.frame.origin = CGPoint(x: CGFloat(location.x),
                                   y: CGFloat(location.y))
    }
    
}
