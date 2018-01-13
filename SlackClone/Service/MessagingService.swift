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
    
    
    var channels = [Channel]()
    
    
    func getAllChannels(completion:@escaping CompletionHandler) {
        let header = [
            "Authorization":"Bearer \(AuthService.sharedInstance.authToken)",
            "Content-Type":"application/json; charset = utf-8"
        ]
        Alamofire.request(URL_FIND_ALL_CHANNEL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil {
                
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
                    completion(true)
                }
            }else{
                debugPrint("error getting all channels")
                completion(false)
            }
        }
        
        
    }
    
    
    
}
