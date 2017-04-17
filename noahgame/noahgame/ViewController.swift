//
//  ViewController.swift
//  NoahGame
//
//  Created by Technorides on 4/16/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var username1: UITextField!
    @IBOutlet var username2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didStart(_ sender: Any) {
        if let name1 = username1.text, !name1.isEmpty,
           let name2 = username2.text, !name2.isEmpty {
            GameManager.shared.createPersonage1(name: name1)
            GameManager.shared.createPersonage2(name: name2)
            
            performSegue(withIdentifier: "startSegue", sender: nil)
        }
    }

}

