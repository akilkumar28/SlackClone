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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- Variable
    
    var avatarName = "profileDefault"
    var avatarColor = "[0.5,0.5,0.5,1]"
    var bgColor:UIColor?
    
    
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
            if bgColor == nil{
                if self.avatarName.contains("light") {
                    self.avatarImageIcon.backgroundColor = UIColor.lightGray
                    self.bgColor = UIColor.lightGray
                }else{
                    self.avatarImageIcon.backgroundColor = UIColor.white
                    self.bgColor = UIColor.white
                }
            }else{
                self.avatarImageIcon.backgroundColor = bgColor
            }
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
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        let color = UIColor(red: r, green: g, blue: b, alpha: 1)
        UIView.animate(withDuration: 0.2) {
            self.avatarImageIcon.backgroundColor = color
        }
        self.bgColor = color
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        activityIndicator.startAnimating()
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
                                self.activityIndicator.stopAnimating()
                                self.performSegue(withIdentifier: UNWIND_SEGUE, sender: nil)
                                NotificationCenter.default.post(NOTIF_USER_DATA_CHANGED)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
