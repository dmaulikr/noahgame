//
//  LoginController.swift
//  NoahGame
//
//  Created by Technorides on 4/18/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signIn(_ sender: Any) {
        guard let email = emailTextField.text, let pass = passwordTextField.text else {
            print("Form is not valid")
            return
        }
        
        NoahService.shared.signIn(email, password: pass, completion: {
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    @IBAction func signUp(_ sender: Any) {
        guard let name = nameTextField.text, let email = emailTextField.text, let pass = passwordTextField.text else {
            print("Form is not valid")
            return
        }
            
        NoahService.shared.signUp(name, email: email, password: pass, completion: {
            self.dismiss(animated: true, completion: nil)
        })
    }
    
}
