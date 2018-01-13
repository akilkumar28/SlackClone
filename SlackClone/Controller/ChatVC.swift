//
//  ChatVC.swift
//  SlackClone
//
//  Created by AKIL KUMAR THOTA on 1/10/18.
//  Copyright © 2018 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    //MARK:- IBOutlets
    @IBOutlet weak var hamBurgerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hamBurgerBtn.addTarget(self.revealViewController(),action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        
        if AuthService.sharedInstance.isLoggedIn {
            AuthService.sharedInstance.findUserByEmail(completion: { (Success) in
                if Success{
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGED, object: nil)
                }
            })
        }
}

}

