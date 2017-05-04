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
    
    private init() {
        let url = Bundle.main.infoDictionary!["databaseUrl"] as! String
        
        FIRDatabase.database().reference(fromURL: url)
    }
    
    
    func fetchUser(_ completion: @escaping (User) -> ()) {
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { snapshot in
            
            if let json = snapshot.value as? [String: Any], let user = User(json: json) {
                user.id = snapshot.key
                completion(user)
            }
            
        })
    }
    
    func fetchPersonage(_ completion: @escaping (Personage) -> ()) {
        FIRDatabase.database().reference().child("personages").observe(.childAdded, with: { snapshot in
            
            if let json = snapshot.value as? [String: Any], let personage = Personage(json: json) {
                completion(personage)
            }
            
        })
    }
    
    
    func signIn(_ uid: String, completion: @escaping (User) -> ()) {
        //fetch user
        FIRDatabase.database().reference().child("users").child(uid).observe(.value, with: { (snapshot) in
            
            if let json = snapshot.value as? [String: Any], let user = User(json: json) {
                
                user.id = snapshot.key
                
                //fetch personage
                FIRDatabase.database().reference().child("personages").child(uid).observe(.value, with: { snapshot in
                    
                    if let json = snapshot.value as? [String: Any], let personage = Personage(json: json) {
                        user.personage = personage
                        completion(user)
                    }
                    
                })
                
            }
            
        })
    }
    
    func signIn(_ email: String, password: String, completion: @escaping (User) -> ()) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { user, error in
            
            if let err = error {
                print(err)
                return
            }
            
            guard let uid = FIRAuth.auth()?.currentUser?.uid else {
                return
            }

            self.signIn(uid, completion: completion)
            
        }
    }
    
    func signUp(_ name: String, email: String, password: String, profileImage: UIImage, completion: @escaping (User) -> ()) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            
            if let err = error {
                print(err)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }

            //successfully authenticated user
//            let imageName = UUID().uuidString
//            self.saveImage(profileImage, path: "profile_images", filename: "\(imageName).png") { url in }
            
            let values = ["email": email]
//                          "profileImageUrl": url]
            
            self.createUser(withUID: uid, values: values) { user in
            
                let personage = Personage(name: name)
                
                self.createPersonage(personage, withUID: uid) {
                    user.personage = personage
                    completion(user)
                }
                
            }
            
        })
    }
    
    func createPersonage(_ personage: Personage, withUID uid: String, completion: @escaping () -> ()) {
        
        guard let values = personage.toJSON() else {
            return
        }
        
        let ref = FIRDatabase.database().reference().child("personages").child(uid)
        
        ref.updateChildValues(values) { error, _ in
            
            if let err = error {
                print(err)
                return
            }
            
            completion()
            
        }
        
    }
    
    private func createUser(withUID uid: String, values: [String: Any], completion: @escaping (User) -> ()) {
        let usersRef = FIRDatabase.database().reference().child("users").child(uid)
        usersRef.updateChildValues(values) { error, _ in
            
            if let err = error {
                print(err)
                return
            }
            
            if let user = User(json: values) {
                user.id = uid
                completion(user)
            }
            
        }
    }
    
    private func saveImage(_ image: UIImage, path: String, filename: String, completion: @escaping (String) -> ()) {
        let storageRef = FIRStorage.storage().reference().child(path).child(filename)
        
        if let uploadData = UIImagePNGRepresentation(image) {
            storageRef.put(uploadData, metadata: nil) { metadata, error in
                
                if let err = error {
                    print(err)
                    return
                }
                
                if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                    completion(profileImageUrl)
                }
                
            }
        }
    }

}


// MARK: Challenge

extension NoahService {
    
    func createChallenge(_ challenge: Challenge, completion: @escaping (String) -> ()) {
        
        guard let values = challenge.toJSON() else {
            return
        }
        
        let ref = FIRDatabase.database().reference().child("challenges").childByAutoId()
        
        ref.updateChildValues(values) { error, dataref in
            
            if let err = error {
                print(err)
                return
            }
            
            completion(dataref.key)

        }
    }
    
    func observeSkills(challengeId: String, completion: @escaping (String) -> ()) {
        FIRDatabase.database().reference().child("challenges").child(challengeId).child("skills").child("description").observe(.childChanged, with: { snapshot in
            
            if let json = snapshot.value as? [String: String], let skillname = json["description"] {
//                message.id = snapshot.key
                completion(skillname)
                
            }
            
        })
    }
    
    func activateSkill(_ skillName: String, challengeId: String, completion: @escaping (String) -> ()) {
        let ref = FIRDatabase.database().reference().child("challenges").child(challengeId).child("skills")
        
        let values = ["description": skillName]
        
        ref.updateChildValues(values) { error, _ in
            
            if let err = error {
                print(err)
                return
            }
            
            completion(skillName)
            
        }
    }
    
    
    func sendMessage(_ message: String, toId: String, completion: (() -> Void)?) {
        
        if let fromId = FIRAuth.auth()?.currentUser?.uid {
            let ref = FIRDatabase.database().reference().child("messages").childByAutoId()
            
            let timestamp = NSNumber(value: Date().timeIntervalSince1970)
            let values = ["fromId": fromId,
                          "text": message,
                          "toId": toId,
                          "timestamp": timestamp] as [String : Any]
            
            ref.updateChildValues(values) { error, _ in
                
                if let err = error {
                    print(err)
                    return
                }
                
                completion?()
            }
        }
        
    }
    
}
