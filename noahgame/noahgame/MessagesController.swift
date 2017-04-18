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
            
            if let user = UserDefaults.standard.object(forKey: "user_name") as? User {
                self.navigationItem.title = user.name
            }
            
        }
    }
    
    func newMessage() {
        let controller = NewMessageController()
        controller.source = self
        
        let navController = UINavigationController(rootViewController: controller)
        present(navController, animated: true, completion: nil)
    }
    
    func showGameController(withUser user: User) {
        let controller = GameController()
        controller.user = user
        
        navigationController?.pushViewController(controller, animated: true)
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
