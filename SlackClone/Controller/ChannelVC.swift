//
//  ChannelVC.swift
//  SlackClone
//
//  Created by AKIL KUMAR THOTA on 1/10/18.
//  Copyright © 2018 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var profileImageView: RoundedImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.width - 60
        
        NotificationCenter.default.addObserver(self, selector: #selector(userStateChanged(_:)), name: NOTIF_USER_DATA_CHANGED, object: nil)

    }
    
    //MARK:- Functions
    
    @objc func userStateChanged(_ notif:Notification) {
        if AuthService.sharedInstance.isLoggedIn {
            self.profileImageView.image = UIImage(named: UserDataService.sharedInstance.avatarName)
            self.loginBtn.setTitle(UserDataService.sharedInstance.name, for: .normal)
            self.profileImageView.backgroundColor = UserDataService.sharedInstance.getAvatarColor(component: UserDataService.sharedInstance.avatarColor)
        }else{
            self.profileImageView.image = UIImage(named: "profileDefault")
            self.loginBtn.setTitle("Login", for: .normal)
            self.profileImageView.backgroundColor = UIColor.clear
        }
    }
    
    //MARK:- IBActions
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        if AuthService.sharedInstance.isLoggedIn{
            
            let profileVC = ProfileViewVC()
            profileVC.modalPresentationStyle = .custom
            present(profileVC, animated: true, completion: nil)
            
        }else{
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    @IBAction func unwindFromSignUpVC(sender:UIStoryboardSegue){
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

}
