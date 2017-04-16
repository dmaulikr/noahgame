//
//  Server.swift
//  NoahKit
//
//  Created by Franklin Fox on 6/3/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

public class Server: NSObject {
    
    private static var instance : Server? = nil
    var socket: SocketAPI!
    
    public static func sharedInstance() -> Server {
        if instance == nil {
            instance = Server()
        }
        
        return instance!
    }

    private override init() {
        socket = SocketAPI()
    }
    
    public func connect() {
        socket.connect()
    }
    
    public func disconnect() {
        socket.disconnect()
    }
    
    public func activateSkill(personage: PersonageProtocol, skill: Skill, target: PersonageProtocol?) {
        var message = ["personage": personage.name, "skillName": skill.name]
        
        if target != nil {
            message["target"] = target?.name
        }
        
        socket.sendMessage(OperationNames.activateSkill.rawValue,
                           message: message as [String: AnyObject])
    }
    
    func personageConnected(personage: PersonageProtocol) {
        let message = ["name": personage.name,
                       "health": personage.health,
                       "energy": personage.energy] as [String : Any]
        
        socket.sendMessage(OperationNames.personageConnected.rawValue, message: message as [String: AnyObject])
    }

}
