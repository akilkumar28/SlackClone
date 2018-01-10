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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //MARK:- IBActions
    @IBAction func loginInTapped(_ sender: Any) {
    }
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func signUpBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: TO_SIGNUPVC, sender: nil)
    }
    
    
}
