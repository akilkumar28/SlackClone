//
//  File.swift
//  SlackClone
//
//  Created by AKIL KUMAR THOTA on 1/10/18.
//  Copyright © 2018 AKIL KUMAR THOTA. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success:Bool) -> ()


//MARK:- Notification constants

let NOTIF_USER_DATA_CHANGED = Notification.Name("notificationUserDataChanged")
let NOTIF_CHANNEL_SELECTED = Notification.Name("notificationChannelSelected")
let NOTIF_CHANNEL_LOADED = Notification.Name("notificationChannelLoaded")



//MARK:- Reuse Id

let collectionViewCellID = "collectionCell"
let tableViewCellID = "channelCell"
let messageCellID = "messageCell"

//MARK:- URL
let BASE_URL = "https://slackclone28.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_CREATE_USER = "\(BASE_URL)user/add"
let URL_FIND_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_FIND_ALL_CHANNEL = "\(BASE_URL)channel"
let URL_MESSAGES_BY_CHANNEL = "\(BASE_URL)message/byChannel/"


//MARK:- Seagues
let TO_LOGIN = "toLogin"
let TO_SIGNUPVC = "toSignUpVC"
let UNWIND_SEGUE = "unwindSegue"
let TO_AVATAR_PICKER = "toAvatarPicker"

//MARK:- UserDefaults Tokens
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL_KEY = "userEmail"
