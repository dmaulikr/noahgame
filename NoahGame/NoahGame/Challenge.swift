//
//  Challenge.swift
//  NoahGame
//
//  Created by Technorides on 4/18/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

import Gloss

class Challenge: Glossy {

    var id: String?
    var personage1: Personage?
    var personage2: Personage?
    
    required init?(json: JSON) {
        personage1 = "personage1" <~~ json
        personage2 = "personage2" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "personage1" ~~> personage1,
            "personage2" ~~> personage2
            ])
    }
    
    init(personage1: Personage? = nil, personage2: Personage? = nil) {
        self.personage1 = personage1
        self.personage2 = personage2
    }
    
}
