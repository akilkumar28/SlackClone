//
//  File.swift
//  SlackClone
//
//  Created by AKIL KUMAR THOTA on 1/10/18.
//  Copyright © 2018 AKIL KUMAR THOTA. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success:Bool) -> ()

//MARK:- URL
let BASE_URL = "https://slackclone28.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_CREATE_USER = "\(BASE_URL)user/add"

//MARK:- Seagues
let TO_LOGIN = "toLogin"
let TO_SIGNUPVC = "toSignUpVC"
let UNWIND_SEGUE = "unwindSegue"

//MARK:- UserDefaults Tokens
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL_KEY = "userEmail"
