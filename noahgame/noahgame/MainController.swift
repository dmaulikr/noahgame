//
//  MainController.swift
//  NoahGame
//
//  Created by Technorides on 4/16/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.backgroundColor = .white
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(signOut))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newChallenge))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkIfUserIsLoggedIn()
    }
    
    func checkIfUserIsLoggedIn() {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            // Fix error: Unbalanced calls to begin/end appearance transitions for nav
            perform(#selector(signOut), with: nil, afterDelay: 0)
            return
        }
        
        NoahService.shared.signIn(uid) { user in
            Session.shared.user = user
            self.navigationItem.title = user.personage?.name
        }
    }
    
    func newChallenge() {
        let controller = NewChallengeController()
        controller.source = self
        
        let navController = UINavigationController(rootViewController: controller)
        present(navController, animated: true, completion: nil)
    }
    
    func showGameController(withPersonage personage: Personage) {
        let controller = GameController()
        controller.personage = personage
        
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
