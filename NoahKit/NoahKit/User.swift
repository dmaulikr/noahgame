//
//  User.swift
//  NoahGame
//
//  Created by Technorides on 4/18/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

import Gloss

class User: Decodable {
    var name: String?
    var email: String?
    
    required init?(json: JSON) {
        name = "name" <~~ json
        email = "email" <~~ json
    }
    
}
