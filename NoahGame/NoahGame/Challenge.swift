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
    var personage: Personage?
    var enemy: Personage?
    
    required init?(json: JSON) {
        personage = "personage" <~~ json
        enemy     = "enemy" <~~ json
    }
    
    func toJSON() -> JSON? {
        return jsonify([
            "personage" ~~> personage,
            "enemy" ~~> enemy
            ])
    }
    
    init(personage: Personage, enemy: Personage) {
        self.personage = personage
        self.enemy = enemy
    }
    
}
