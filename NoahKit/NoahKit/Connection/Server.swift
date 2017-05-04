//
//  Server.swift
//  NoahKit
//
//  Created by Franklin Fox on 6/3/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

class Server {
    
    static let shared = Server()
    var socket: SocketAPI

    private init() {
        socket = SocketAPI()
    }
    
    func connect() {
        socket.connect()
    }
    
    func disconnect() {
        socket.disconnect()
    }
    
    func activateSkill(_ personage: Attackable, skill: Skill, target: Attackable?) {
        var message = ["personage": personage.name, "skillName": skill.name] as [String : Any]
        
        if target != nil {
            message["target"] = target?.name
        }
        
        socket.sendMessage(OperationNames.activateSkill.rawValue,
                           message: message as [String: AnyObject])
    }
    
    func personageConnected(personage: Attackable) {
        let message = ["name": personage.name,
                       "health": personage.health,
                       "energy": personage.energy] as [String : Any]
        
        socket.sendMessage(OperationNames.personageConnected.rawValue, message: message as [String: AnyObject])
    }

}
