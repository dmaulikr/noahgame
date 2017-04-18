//
//  DatabaseService.swift
//  NoahGame
//
//  Created by Technorides on 4/18/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

import Firebase

class DatabaseService {
    static let shared = DatabaseService()
    let url = "https://noahgame-5f590.firebaseio.com/"
    
    private init() { }
    
    func registerUser(withName name: String, email: String, password: String) {
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
            
            let ref = FIRDatabase.database().reference(fromURL: self.url)
            
            let usersReference = ref.child("users").child(uid)
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil {
                    print(err!)
                    return
                }
                
                print("saved user successfully into firebase db")
                
            })
            
        })
    }

}
