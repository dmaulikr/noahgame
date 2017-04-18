//
//  ViewController.swift
//  NoahGame
//
//  Created by Technorides on 4/16/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

import UIKit
import FirebaseAuth

class MessagesController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(signOut))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newMessage))
        
        checkIfUserIsLoggedIn()
    }
    
    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            // Fix error: Unbalanced calls to begin/end appearance transitions for nav
            perform(#selector(signOut), with: nil, afterDelay: 0)
        } else {
         
            /*guard let uid = FIRAuth.auth()?.currentUser?.uid else {
                return
            }
            
            FIRDatabase.database().reference().child("users").child(uid).observe(.value, with: { (snapshot) in
                
                if let info = snapshot.value as? [String: AnyObject] {
                    self.navigationItem.title = info["name"] as? String
                }
                
            })*/
            
        }
    }
    
    func newMessage() {
        let controller = NewMessageController()
        let navController = UINavigationController(rootViewController: controller)
        present(navController, animated: true, completion: nil)
    }
    
    func signOut() {
        
        do {
            try FIRAuth.auth()?.signOut()
        }
        catch let error {
            print(error)
        }
        
        let controller = LoginController()
        present(controller, animated: true, completion: nil)
        
    }
    
}

//GameManager.shared.createPersonage1(name: name1)
//GameManager.shared.createPersonage2(name: name2)

//performSegue(withIdentifier: "startSegue", sender: nil)
