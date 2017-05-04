//
//  User.swift
//  NoahGame
//
//  Created by Technorides on 4/18/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

import Gloss

class User: Glossy {
    
    var id: String?
    var email: String?
    var profileImageUrl: String?
    var personage: Personage?
    
    
    required init?(json: JSON) {
        email = "email" <~~ json
        profileImageUrl = "profileImageUrl" <~~ json
        personage = "personage" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "email" ~~> email,
            "profileImageUrl" ~~> profileImageUrl,
            "personage" ~~> personage
            ])
    }
    
}
