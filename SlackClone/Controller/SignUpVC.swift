//
//  SignUpVC.swift
//  SlackClone
//
//  Created by AKIL KUMAR THOTA on 1/11/18.
//  Copyright © 2018 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var avatarImageIcon: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
       avatarImageIcon.addGestureRecognizer(tapGesture)
    }
    
    //MARK:- Functions
    
    @objc func imageTapped(){
        chooseAvatartBtnTapped(UIButton())
    }

    //MARK:- IBActions

    
    @IBAction func chooseAvatartBtnTapped(_ sender: Any) {
    }
    @IBAction func generateBackgroundColorTapped(_ sender: Any) {
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        
        guard let email = emailTxtField.text, emailTxtField.text != "" else {return}
        guard let password = passwordTxtField.text, passwordTxtField.text != "" else{return}
        AuthService.sharedInstance.registerUser(email: email, password: password) { (success) in
            if success {
                print("registered user")
            }else{
                print("failure")
            }
        }
    }
}
