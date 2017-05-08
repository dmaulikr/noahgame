//
//  Session.swift
//  NoahGame
//
//  Created by Franklin Fox on 5/4/17.
//  Copyright © 2017 francarfox. All rights reserved.
//

protocol SessionDelegate {
    func receiveChallenge(of enemy: Personage, completion: @escaping () -> Void)
    func startChallenge(_ challenge: Challenge)
}


class Session {
    static let shared = Session()
    var user: User?
    
    var personage: Personage? {
        get {
            return user?.personage
        }
    }
    
    var challenge: Challenge?
    
    var delegate: SessionDelegate?
    
    private init() { }
    
    func receiveChallenge(of enemy: Personage) {
        delegate?.receiveChallenge(of: enemy) {
            
            if let ch = self.challenge {
                self.delegate?.startChallenge(ch)
            }
        }
    }
    
    func startChallenge(_ challenge: Challenge) {
        delegate?.startChallenge(challenge)
    }
    
}
