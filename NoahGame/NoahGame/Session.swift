//
//  Session.swift
//  NoahGame
//
//  Created by Technorides on 5/4/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

protocol SessionDelegate {
    func receiveChallenge(_ enemyName: String)
}


class Session {
    static let shared = Session()
    var user: User?
    
    var personage: Personage? {
        get {
            return user?.personage
        }
    }
    
    var delegate: SessionDelegate?
    
    private init() { }
    
    func receiveChallenge(_ enemyName: String) {
        delegate?.receiveChallenge(enemyName)
    }
}
