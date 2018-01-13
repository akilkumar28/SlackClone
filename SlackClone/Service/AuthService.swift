//
//  AuthService.swift
//  SlackClone
//
//  Created by AKIL KUMAR THOTA on 1/11/18.
//  Copyright © 2018 AKIL KUMAR THOTA. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    
    private init(){}
    
    static let sharedInstance = AuthService()
    
    
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set{
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
            if newValue {
                MessagingService.sharedInstance.getAllChannels(completion: { (success) in
                    if success {
                        print("got all channels")
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGED, object: nil)
                    }
                })
            }
        }
    }
    var authToken : String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set{
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    var userEmail : String {
        get {
            return defaults.value(forKey: USER_EMAIL_KEY) as! String
        }
        set{
            defaults.set(newValue, forKey: USER_EMAIL_KEY)
        }
    }
    
    func registerUser(email:String,password:String,completion:@escaping CompletionHandler) {
        
        let lowercasedEmail = email.lowercased()
        
        let header = [
            "Content-Type":"application/json; charset = utf-8"
        ]
        let body = [
            "email":lowercasedEmail,
            "password":password
        ]
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            if response.result.error == nil {
                completion(true)
            }else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email:String,password:String,completion:@escaping CompletionHandler) {
        let lowercasedEmail = email.lowercased()
        
        let header = [
            "Content-Type":"application/json; charset = utf-8"
        ]
        let body = [
            "email":lowercasedEmail,
            "password":password
        ]
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                guard let json = try? JSON(data:data) else {return}
                self.userEmail = json["user"].stringValue
                self.authToken = json["token"].stringValue
                completion(true)
            }else{
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
    
    func createUser(name:String,email:String,avatarName:String,avatarColor:String,completion:@escaping CompletionHandler){
        
        let lowercasedEmail = email.lowercased()
        
        let header = [
            "Authorization":"Bearer \(AuthService.sharedInstance.authToken)",
            "Content-Type":"application/json; charset = utf-8"
        ]
        let body = [
            "name": name,
            "email": lowercasedEmail,
            "avatarName": avatarName,
            "avatarColor" : avatarColor
        ]
        
        Alamofire.request(URL_CREATE_USER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                guard let json = try? JSON(data: data) else {return}
                let jname = json["name"].stringValue
                let jemail = json["email"].stringValue
                let jid = json["_id"].stringValue
                let javatarName = json["avatarName"].stringValue
                let javatarColor = json["avatarColor"].stringValue
                UserDataService.sharedInstance.setUserData(id: jid, color: javatarColor, avatarName: javatarName, email: jemail, name: jname)
                AuthService.sharedInstance.isLoggedIn = true
                completion(true)
            }else{
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }

    }
    
    
    func findUserByEmail(completion:@escaping CompletionHandler) {
        
        let header = [
            "Authorization":"Bearer \(AuthService.sharedInstance.authToken)",
            "Content-Type":"application/json; charset = utf-8"
        ]

        Alamofire.request("\(URL_FIND_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                guard let json = try? JSON(data: data) else {return}
                let jname = json["name"].stringValue
                let jemail = json["email"].stringValue
                let jid = json["_id"].stringValue
                let javatarName = json["avatarName"].stringValue
                let javatarColor = json["avatarColor"].stringValue
                UserDataService.sharedInstance.setUserData(id: jid, color: javatarColor, avatarName: javatarName, email: jemail, name: jname)
                AuthService.sharedInstance.isLoggedIn = true
                completion(true)
            }else{
                debugPrint(response.result.error as Any)
                completion(false)
            }
        }
    }
      
}
