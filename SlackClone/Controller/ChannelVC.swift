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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.width - 60

    }
    
    //MARK:- IBActions
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    

}
