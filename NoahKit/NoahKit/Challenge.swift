//
//  Challenge.swift
//  NoahGame
//
//  Created by Technorides on 4/18/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

import Gloss

class Challenge: Decodable {

    var pj1Name: String?
    var pj2Name: String?
    var pj1Level, pj1Health, pj1Energy: Int?
    var pj2Level, pj2Health, pj2Energy: Int?
    
    required init?(json: JSON) {
        pj1Name     = "pj1_name" <~~ json
        pj1Level    = "pj1_level" <~~ json
        pj1Health   = "pj1_health" <~~ json
        pj1Energy   = "pj1_energy" <~~ json
        
        pj2Name     = "pj2_name" <~~ json
        pj2Level    = "pj2_level" <~~ json
        pj2Health   = "pj2_health" <~~ json
        pj2Energy   = "pj2_energy" <~~ json
    }
    
}
