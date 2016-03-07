//
//  SocketAPI.swift
//  NoahKit
//
//  Created by Franklin Fox on 6/3/16.
//  Copyright © 2016 FoxDev. All rights reserved.
//

import UIKit

class SocketAPI: NSObject {

    var socket: SocketIOClient!
    
    override init() {
        super.init()
        
        let url: String = NSBundle .mainBundle().objectForInfoDictionaryKey("SocketAPI") as! String
        socket = SocketIOClient(socketURL: NSURL(string: url)!, options: [.Log(true), .ForcePolling(true)])
        
        self.setup()
    }
    
    func setup() {
        socket.on("connect") { data, ack in
            print("Socket connected...")
            
            NSNotificationCenter.defaultCenter().postNotificationName(OperationNames.PersonageConnected.rawValue, object: nil)
        }
        
        socket.on(OperationNames.ActivateSkill.rawValue) { data, ack in
            let message = data[0] as! [String: AnyObject]
            
            NSNotificationCenter.defaultCenter().postNotificationName(OperationNames.ActivateSkill.rawValue, object: message)
        }
        
        socket.on(OperationNames.PersonageConnected.rawValue) { data, ack in
            let message = data[0] as! [String: AnyObject]
            
            print(message)
        }
    }
    
    func connect() {
        socket.connect()
    }
    
    func disconnect() {
        socket.disconnect()
    }
    
    func sendMessage(identifier: String, message: [String: AnyObject]) {
        socket.emit(identifier, message)
    }
    
}
