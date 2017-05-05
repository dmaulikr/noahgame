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
    
    
    func fetchUser(_ completion: @escaping (User) -> Void) {
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { snapshot in
            
            if let json = snapshot.value as? [String: Any], let user = User(json: json) {
                user.id = snapshot.key
                completion(user)
            }
            
        })
    }
    
    func fetchPersonage(_ completion: @escaping (Personage) -> Void) {
        FIRDatabase.database().reference().child("personages").observe(.childAdded, with: { snapshot in
            
            if let json = snapshot.value as? [String: Any], let personage = Personage(json: json) {
                personage.id = snapshot.key
                completion(personage)
            }
            
        })
    }
    
    
    func signIn(_ uid: String, completion: @escaping (User) -> Void) {
        //fetch user
        FIRDatabase.database().reference().child("users").child(uid).observe(.value, with: { (snapshot) in
            
            if let json = snapshot.value as? [String: Any], let user = User(json: json) {
                
                user.id = snapshot.key
                
                //fetch personage
                var handle: UInt = 0
                let ref = FIRDatabase.database().reference().child("personages").child(uid)
                    
                handle = ref.observe(.value, with: { snapshot in
                    
                    if let json = snapshot.value as? [String: Any], let personage = Personage(json: json) {
                        ref.removeObserver(withHandle: handle)
                        
                        personage.id = snapshot.key
                        user.personage = personage
                        completion(user)
                    }
                    
                })
                
                //MARK: receive challenges
                ref.observe(.childAdded , with: { snapshot in
                    
                    if let json = snapshot.value as? [String: Any], let enemy = Personage(json: json) {
                        Session.shared.receiveChallenge(of: enemy)
                    }
                    else
                    if "currentChallengeId" == snapshot.key, let challengeId = snapshot.value as? String {
                     
                        self.getChallenge(withId: challengeId) { challenge in
                            Session.shared.startChallenge(challenge)
                        }
                        
                    }
                    
                })
                
                ref.observe(.childChanged , with: { snapshot in
                    
                    if "currentChallengeId" == snapshot.key, let challengeId = snapshot.value as? String {
                        
                        self.getChallenge(withId: challengeId) { challenge in
                            Session.shared.startChallenge(challenge)
                        }
                            
                    }
                    
                })
                
            }
            
        })
    }
    
    func signIn(_ email: String, password: String, completion: @escaping (User) -> Void) {
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
    
    func signUp(_ name: String, email: String, password: String, profileImage: UIImage, completion: @escaping (User) -> Void) {
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
    
    func createPersonage(_ personage: Personage, withUID uid: String, completion: @escaping () -> Void) {
        
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
    
    private func createUser(withUID uid: String, values: [String: Any], completion: @escaping (User) -> Void) {
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
    
    private func saveImage(_ image: UIImage, path: String, filename: String, completion: @escaping (String) -> Void) {
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



extension NoahService {

    // MARK: Challenge
    
    //send push to enemy
    func sendChallenge(to enemy: Personage, completion: @escaping () -> Void) {
        guard let mypj = Session.shared.personage else {
            return
        }
        
        cancelChallenge(to: enemy, mypersonage: mypj, completion: completion)
    }
    
    func cancelChallenge(to enemy: Personage, mypersonage: Personage? = nil, completion: @escaping () -> Void) {
        
        guard let enemyId = enemy.id else {
            return
        }
        
        
        let ref = FIRDatabase.database().reference().child("personages").child(enemyId).child("enemyPending")
        
        if let values = mypersonage?.toJSON() {
        
            ref.updateChildValues(values) { error, dataref in
                self.handlerChallenge(error: error, completion: completion)
            }
            
        } else {
         
            ref.removeValue { error, dataref in
                self.handlerChallenge(error: error, completion: completion)
            }
            
        }
        
    }
    
    private func handlerChallenge(error: Error?, completion: () -> Void) {
        if let err = error {
            print(err)
            return
        }
        
        completion()
    }
    
    func acceptChallenge(to enemy: Personage, completion: @escaping (Challenge) -> Void) {
        guard let mypj = Session.shared.personage, let myId = mypj.id, let enemyId = enemy.id else {
            return
        }
        
        cancelChallenge(to: mypj) {
        
            let challenge = Challenge(personage1: enemy, personage2: mypj)
            
            self.createChallenge(challenge) { id in
                
                challenge.id = id
                
                
                //save currentChallengeId
                let ref = FIRDatabase.database().reference().child("personages")
                
                let values = ["currentChallengeId": id]
                
                ref.child(myId).updateChildValues(values) { error, _ in
                    if let err = error {
                        print(err)
                        return
                    }
                    
                    ref.child(enemyId).updateChildValues(values) { error, _ in
                        if let err = error {
                            print(err)
                            return
                        }
                        
                        completion(challenge)
                    }
                    
                }
                
            }
        
        }
        
    }
    
    func createChallenge(_ challenge: Challenge, completion: @escaping (String) -> Void) {
        
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
    
    func getChallenge(withId id: String, completion: @escaping (Challenge) -> Void) {
        
        let ref = FIRDatabase.database().reference().child("challenges").child(id)
            
        ref.observe(.value, with: { snapshot in
            
            if let json = snapshot.value as? [String: Any], let challenge = Challenge(json: json) {
                challenge.id = id
                completion(challenge)
                
                ref.removeAllObservers()
            }
            
        })
        
    }
    
    
    // MARK: Skills
    
    func observeSkills(challengeId: String, completion: @escaping (String) -> Void) {
        FIRDatabase.database().reference().child("challenges").child(challengeId).child("skills").child("description").observe(.childChanged, with: { snapshot in
            
            if let json = snapshot.value as? [String: String], let skillname = json["description"] {
//                message.id = snapshot.key
                completion(skillname)
                
            }
            
        })
    }
    
    func activateSkill(_ skillName: String, challengeId: String, completion: @escaping (String) -> Void) {
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
        
        guard let fromId = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
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
