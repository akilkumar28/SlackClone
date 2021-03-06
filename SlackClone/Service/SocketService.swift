//
//  SocketService.swift
//  SlackClone
//
//  Created by AKIL KUMAR THOTA on 1/13/18.
//  Copyright © 2018 AKIL KUMAR THOTA. All rights reserved.
//

import Foundation
import SocketIO


class SocketService:NSObject {
    
    //MARK:- Properties
    
    var manager:SocketManager!
    var socket:SocketIOClient!
    static let sharedInstance = SocketService()

    
    
    private override init(){
        super.init()
        manager = SocketManager(socketURL: URL(string: BASE_URL)!)
        socket = manager.defaultSocket
    }
    
    
    
    //MARK:- functions
    
    
    func establishConnection() {
        socket.connect()
    }
    
    func removeConnection() {
        socket.disconnect()
    }
    
    func addChannel(channelName:String,channelDescription:String,completion:@escaping CompletionHandler) {
        
        socket.emit("newChannel", channelName,channelDescription)
        completion(true)
    }
    
    func getChannel(completion:@escaping CompletionHandler) {
        
        socket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else {return}
            guard let channelDesc = dataArray[1] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: channelId)
            MessagingService.sharedInstance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody:String,userId:String,channelId:String,completion:@escaping CompletionHandler){
        let user = UserDataService.sharedInstance
        socket.emit("newMessage", messageBody,userId,channelId,user.name,user.avatarName,user.avatarColor)
        completion(true)
    }
    
    func getMessage(completion:@escaping (_ newMessage:Message) -> Void) {
        
        socket.on("messageCreated") { (dataArray, ack) in
            
            guard let messageBody = dataArray[0] as? String else {return}
            guard let channelId = dataArray[2] as? String else {return}
            guard let userName = dataArray[3] as? String else {return}
            guard let userAvatar = dataArray[4] as? String else {return}
            guard let userAvatarColor = dataArray[5] as? String else {return}
            guard let id = dataArray[6] as? String else {return}
            guard let timeStamp = dataArray[7] as? String else {return}
            
            let newMessage = Message(message: messageBody, userName: userName, channelID: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
            
            completion(newMessage)
        }
        
    }
    
    
    func getTypingusers(completion: @escaping (_ typingUsers: [String:String]) -> Void) {
        
        socket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String:String] else {return}
            completion(typingUsers)
        }
        
    }
    
    
    
    
    
    
    
}
