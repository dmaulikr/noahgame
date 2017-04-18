//
//  NoahService.swift
//  NoahGame
//
//  Created by Technorides on 4/18/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

import Firebase

class NoahService {
    static let shared = NoahService()
    let url = "https://noahgame-5f590.firebaseio.com/"
    
    private init() {
        FIRDatabase.database().reference(fromURL: url)
    }
    
    
    func fetchUser(_ completion: ((User) -> Void)?) {
        FIRDatabase.database().reference().child("users").observeSingleEvent(of: .childAdded, with: { (snapshot) in
            
            if let json = snapshot.value as? [String: Any], let user = User(json: json) {
                completion?(user)
            }
            
        })
    }
    
    
    func signIn(_ email: String, password: String, completion: (() -> Void)? = nil) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            completion?()
            
        })
    }
    
    func signUp(_ name: String, email: String, password: String, completion: (() -> Void)? = nil) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }

            //successfully authenticated user
            let values = ["name": name, "email": email]
            
            let usersRef = FIRDatabase.database().reference().child("users").child(uid)
            usersRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil {
                    print(err!)
                    return
                }
                
                completion?()
                
            })
            
        })
    }

}
