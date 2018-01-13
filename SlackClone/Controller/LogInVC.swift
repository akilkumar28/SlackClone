//
//  LogInVC.swift
//  SlackClone
//
//  Created by AKIL KUMAR THOTA on 1/10/18.
//  Copyright © 2018 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var uesrnameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    lazy var indicator:UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 30)
        activityIndicator.activityIndicatorViewStyle = .gray
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(indicator)
        
    }
    
    //MARK:- IBActions
    @IBAction func loginInTapped(_ sender: Any) {
        indicator.startAnimating()
        guard let userEmail = uesrnameTxtField.text, userEmail != "" else {return}
        guard let password = passwordTxtField.text, password != "" else {return}
        AuthService.sharedInstance.loginUser(email: userEmail, password: password) { (success) in
            if success {
                AuthService.sharedInstance.findUserByEmail(completion: { (Success) in
                    if Success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGED, object: nil)
                        self.indicator.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }else{
                        debugPrint("find user info failed")
                    }
                })
            }else{
                debugPrint("Logging in Failed")
            }
        }
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func signUpBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: TO_SIGNUPVC, sender: nil)
    }
    
    
}
