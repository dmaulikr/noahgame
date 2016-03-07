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
        self.connect()
    }
    
    func setup() {
        socket.on("connect") { data, ack in
            print("Socket connected...")
        }
        
        socket.on(OperationNames.ActivateSkill.rawValue) { data in
            print(data)
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
    
//    func receiveMessage(completionHandler: (messageInfo: [String: AnyObject]) -> Void) {
//        socket.on("newChatMessage") { (dataArray, socketAck) -> Void in
//            var messageDictionary = [String: AnyObject]()
//            messageDictionary["nickname"] = dataArray[0] as! String
//            messageDictionary["message"] = dataArray[1] as! String
//            messageDictionary["date"] = dataArray[2] as! String
//            
//            completionHandler(messageInfo: messageDictionary)
//        }
//    }
    
}
