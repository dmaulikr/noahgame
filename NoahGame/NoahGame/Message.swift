//
//  Message.swift
//  NoahGame
//
//  Created by Franklin Fox on 4/18/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

import Gloss

class Message: Decodable {

    var id: String?
    var fromId: String?
    var text: String?
    var toId: String?
    var date: Date?
    
    required init?(json: JSON) {
        fromId = "fromId" <~~ json
        text = "text" <~~ json
        toId = "toId" <~~ json
        
        if let timestamp: NSNumber = "timestamp" <~~ json {
            date = Date(timeIntervalSince1970: timestamp.doubleValue)
        }
    }
    
}
