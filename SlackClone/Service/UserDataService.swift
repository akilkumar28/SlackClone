//
//  UserDataService.swift
//  SlackClone
//
//  Created by AKIL KUMAR THOTA on 1/11/18.
//  Copyright © 2018 AKIL KUMAR THOTA. All rights reserved.
//

import Foundation


class UserDataService {
    
    private init() {}
    static let sharedInstance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id:String,color:String,avatarName:String,email:String,name:String) {
        self.id = id
        self.avatarName = avatarName
        self.avatarColor = color
        self.email = email
        self.name = name
    }
    
    func updateAvatarName(avatarName:String){
        self.avatarName = avatarName
    }
    
    func getAvatarColor(component:String) -> UIColor {
        
        let scanner = Scanner(string: component)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a :NSString?
        
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        guard let rUnrapped = r else {return defaultColor}
        guard let gUnrapped = g else {return defaultColor}
        guard let bUnrapped = b else {return defaultColor}
        guard let aUnrapped = a else {return defaultColor}
        
        let rfloat = CGFloat(rUnrapped.doubleValue)
        let gfloat = CGFloat(gUnrapped.doubleValue)
        let bfloat = CGFloat(bUnrapped.doubleValue)
        let afloat = CGFloat(aUnrapped.doubleValue)
        
        let newColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        return newColor

    }
    
}
