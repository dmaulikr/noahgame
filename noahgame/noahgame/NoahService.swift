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
    private let url = "https://noahgame-5f590.firebaseio.com/"
    
    private init() {
        FIRDatabase.database().reference(fromURL: url)
    }
    
    
    func fetchUser(_ completion: @escaping (User) -> Void) {
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let json = snapshot.value as? [String: Any],
                let user = User(json: json) {
                
                user.id = snapshot.key
                completion(user)
                
            }
            
        })
    }
    
    
    func signIn(_ email: String, password: String, completion: ((User) -> Void)?) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            guard let uid = FIRAuth.auth()?.currentUser?.uid else {
                return
            }

            FIRDatabase.database().reference().child("users").child(uid).observe(.value, with: { (snapshot) in

                if let json = snapshot.value as? [String: Any],
                    let user = User(json: json) {
                    
                    user.id = snapshot.key
                    completion?(user)
                    
                }

            })
            
        })
    }
    
    func signUp(_ name: String, email: String, password: String, profileImage: UIImage, completion: ((User) -> Void)?) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }

            //successfully authenticated user
            let imageName = UUID().uuidString
            let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).png")
            
            if let uploadData = UIImagePNGRepresentation(profileImage) {
                storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                    
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                        let values = ["name": name,
                                      "email": email,
                                      "profileImageUrl": profileImageUrl]
                        
                        self.registerUserIntoDatabase(withUID: uid, values: values, completion: completion)
                    }
                    
                })
            }
            
        })
    }
    
    private func registerUserIntoDatabase(withUID uid: String, values: [String: String], completion: ((User) -> Void)?) {
        let usersRef = FIRDatabase.database().reference().child("users").child(uid)
        usersRef.updateChildValues(values, withCompletionBlock: { (error, _) in
            
            if error != nil {
                print(error!)
                return
            }
            
            if let user = User(json: values) {
                completion?(user)
            }
            
        })
    }

}

extension NoahService {
    
    func createChallenge(personage1: Attackable, personage2: Attackable, completion: @escaping (Challenge) -> Void) {
        
        let ref = FIRDatabase.database().reference().child("challenges").childByAutoId()

        let values = ["pj1_name":   personage1.name,
                      "pj1_level":  personage1.level,
                      "pj1_health": personage1.health,
                      "pj1_energy": personage1.energy,
                      "pj2_name":   personage2.name,
                      "pj2_level":  personage2.level,
                      "pj2_health": personage2.health,
                      "pj2_energy": personage2.energy] as [String : Any]
        
        ref.updateChildValues(values, withCompletionBlock: { (error, _) in
            
            if error != nil {
                print(error!)
                return
            }
            
            if let challenge = Challenge(json: values) {
                completion(challenge)
            }
            
        })
    }
    
    func observeMessages(_ completion: @escaping (Message) -> Void) {
        FIRDatabase.database().reference().child("messages").observe(.childAdded, with: { (snapshot) in
            
            if let json = snapshot.value as? [String: Any],
                let message = Message(json: json) {
                
                message.id = snapshot.key
                completion(message)
                
            }
            
        })
    }
    
    
    func sendMessage(_ message: String, toId: String, completion: (() -> Void)?) {
        
        if let fromId = FIRAuth.auth()?.currentUser?.uid {
            let ref = FIRDatabase.database().reference().child("messages").childByAutoId()
            
            let timestamp = NSNumber(value: Date().timeIntervalSince1970)
            let values = ["fromId": fromId,
                          "text": message,
                          "toId": toId,
                          "timestamp": timestamp] as [String : Any]
            
            ref.updateChildValues(values, withCompletionBlock: { (error, _) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                completion?()
            })
        }
        
    }
    
}
