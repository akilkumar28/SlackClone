//
//  MessagingService.swift
//  SlackClone
//
//  Created by AKIL KUMAR THOTA on 1/13/18.
//  Copyright © 2018 AKIL KUMAR THOTA. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessagingService {
    
    private init(){}
    
    static let sharedInstance = MessagingService()
    
    //MARK:- Properties
    
    var channels = [Channel]()
    var messages = [Message]()
    var selectedChannel:Channel?
    
    
    //MARK:- Functions
    
    func getAllChannels(completion:@escaping CompletionHandler) {
        let header = [
            "Authorization":"Bearer \(AuthService.sharedInstance.authToken)",
            "Content-Type":"application/json; charset = utf-8"
        ]
        Alamofire.request(URL_FIND_ALL_CHANNEL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil {
                self.clearAllchannels()
                guard let data = response.data else {return}
                guard let json = try? JSON(data: data) else {return}
                if let channelArray = json.array {
                    for channel in channelArray {
                        let id = channel["_id"].stringValue
                        let name = channel["name"].stringValue
                        let description = channel["description"].stringValue
                        let newChannel = Channel(channelTitle: name, channelDescription: description, id: id)
                        self.channels.append(newChannel)
                    }
                    NotificationCenter.default.post(name: NOTIF_CHANNEL_LOADED, object: nil)
                    completion(true)
                }
            }else{
                debugPrint("error getting all channels")
                completion(false)
            }
        }
 
    }
    
    
    func getAllMessagesForChannel(channelId:String,completion:@escaping CompletionHandler){
        let header = [
            "Authorization":"Bearer \(AuthService.sharedInstance.authToken)",
            "Content-Type":"application/json; charset = utf-8"
        ]
        Alamofire.request("\(URL_MESSAGES_BY_CHANNEL)\(channelId)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil {
                self.clearAllMessages()
                guard let data = response.data else {return}
                guard let jsonData = try? JSON(data: data).array else {return}
                if let messageArray = jsonData {
                    for message in messageArray {
                        let messageBody = message["messageBody"].stringValue
                        let channelId = message["channelId"].stringValue
                        let id = message["_id"].stringValue
                        let userName = message["userName"].stringValue
                        let userAvatar = message["userAvatar"].stringValue
                        let userAvatarColor = message["userAvatarColor"].stringValue
                        let timeStamp = message["timeStamp"].stringValue
                        
                        let newMessage = Message(message: messageBody, userName: userName, channelID: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
                        self.messages.append(newMessage)
                    }
                    completion(true)
                }                
            }else{
                debugPrint("error gettig messages for a channel")
                completion(false)
            }
        }
        
    }
    
    
    
    func clearAllMessages(){
        messages.removeAll()
    }
    
    func clearAllchannels() {
        channels.removeAll()
    }

}
