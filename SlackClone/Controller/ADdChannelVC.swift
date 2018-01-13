//
//  ADdChannelVC.swift
//  SlackClone
//
//  Created by AKIL KUMAR THOTA on 1/13/18.
//  Copyright © 2018 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class ADdChannelVC: UIViewController {
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var channelDescTxtFld: UITextField!
    @IBOutlet weak var channelNameTxtFld: UITextField!
    @IBOutlet weak var bgView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.bgView.addGestureRecognizer(tapGesture)
    }
    
    //MARK:- Functions
    
    @objc func viewTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    
    
    //MARK:- IBActions

    @IBAction func closeBtnPrssd(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func createChannelTapped(_ sender: Any) {
        
        guard let channelName = channelNameTxtFld.text, channelName != "" else {return}
        guard let channelDescription = channelDescTxtFld.text, channelDescription != "" else {return}
        
        
        SocketService.sharedInstance.addChannel(channelName: channelName, channelDescription: channelDescription) { (Success) in
            if Success {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
