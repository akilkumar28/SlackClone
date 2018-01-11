//
//  ProfileViewVC.swift
//  SlackClone
//
//  Created by AKIL KUMAR THOTA on 1/11/18.
//  Copyright © 2018 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class ProfileViewVC: UIViewController {
    
    //MARK:- IBOutlets

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var hoveringVew: UIView!
    
    @IBOutlet weak var bgView: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(screenTappedOutside))
        bgView.addGestureRecognizer(tapGesture)
        hoveringVew.layer.cornerRadius = 10.0
        setUpViews()
        
    }
    
    //MARK:- Functions
    
    @objc func screenTappedOutside() {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setUpViews() {
        profileImageView.image = UIImage(named: UserDataService.sharedInstance.avatarName)
        profileImageView.backgroundColor = UserDataService.sharedInstance.getAvatarColor(component: UserDataService.sharedInstance.avatarColor)
        nameLabel.text = UserDataService.sharedInstance.name
        emailLabel.text = UserDataService.sharedInstance.email
    }
    
    //MARK:- IBActions
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutBtnPrssd(_ sender: Any) {
        
        UserDataService.sharedInstance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGED, object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    

}
