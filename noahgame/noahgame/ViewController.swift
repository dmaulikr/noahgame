//
//  ViewController.swift
//  NoahGame
//
//  Created by Technorides on 4/16/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didStart(_ sender: Any) {
        if let name = nameTextField.text, !name.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let pass = passwordTextField.text, !pass.isEmpty {
            //GameManager.shared.createPersonage1(name: name1)
            //GameManager.shared.createPersonage2(name: name2)
            
            //performSegue(withIdentifier: "startSegue", sender: nil)
            
            DatabaseService.shared.registerUser(withName: name, email: email, password: pass)
            
        }
    }

}

