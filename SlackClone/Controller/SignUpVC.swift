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
    
    //MARK:- Variable
    
    var avatarName = "profileDefault"
    var avatarColor = "[0.5,0.5,0.5,1]"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
       avatarImageIcon.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDataService.sharedInstance.avatarName != "" {
            self.avatarImageIcon.image = UIImage(named: UserDataService.sharedInstance.avatarName)
            self.avatarName = UserDataService.sharedInstance.avatarName
        }
    }
    
    //MARK:- Functions
    
    @objc func imageTapped(){
        chooseAvatartBtnTapped(UIButton())
    }

    //MARK:- IBActions

    @IBAction func closeBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: UNWIND_SEGUE, sender: nil)
    }
    
    @IBAction func chooseAvatartBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    @IBAction func generateBackgroundColorTapped(_ sender: Any) {
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        
        guard let email = emailTxtField.text, emailTxtField.text != "" else {return}
        guard let password = passwordTxtField.text, passwordTxtField.text != "" else{return}
        guard let userName = usernameTxtField.text, usernameTxtField.text != "" else{return}
        AuthService.sharedInstance.registerUser(email: email, password: password) { (success) in
            if success {
                print("registered user")
                AuthService.sharedInstance.loginUser(email: email, password: password) { (success) in
                    if success{
                        print("logged in")
                        AuthService.sharedInstance.createUser(name: userName, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success{
                                self.performSegue(withIdentifier: UNWIND_SEGUE, sender: nil)
                                
                            }else{
                                print("creating unsuccessfull")
                            }
                        })
                    }else{
                        print("log in failed")
                    }
                }
            }else{
                print("failure")
            }
        }
        
    }
}
