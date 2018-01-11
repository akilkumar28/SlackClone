//
//  AuthService.swift
//  SlackClone
//
//  Created by AKIL KUMAR THOTA on 1/11/18.
//  Copyright © 2018 AKIL KUMAR THOTA. All rights reserved.
//

import Foundation
import Alamofire

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
    
}
