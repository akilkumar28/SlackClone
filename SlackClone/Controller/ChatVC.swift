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
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var messageTxtFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bindToKeyboard()
        hamBurgerBtn.addTarget(self.revealViewController(),action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(channelSelected), name: NOTIF_CHANNEL_SELECTED, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userDataDidChange), name: NOTIF_USER_DATA_CHANGED, object: nil)
        
        if AuthService.sharedInstance.isLoggedIn {
            AuthService.sharedInstance.findUserByEmail(completion: { (Success) in
                if Success{
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_CHANGED, object: nil)
                }
            })
        }
    }
    
    //MARK:- Functions
    
    @objc func handleTap() {
        self.view.endEditing(true)
    }
    
    @objc func userDataDidChange(){
        if AuthService.sharedInstance.isLoggedIn {
            onLoginGetMessages()
        }else{
            self.channelNameLbl.text = "Please Log In"
        }
    }
    
    func onLoginGetMessages() {
        MessagingService.sharedInstance.getAllChannels(completion: { (Success) in
            if Success {
                print("getting all channels here")
                if MessagingService.sharedInstance.channels.count > 0 {
                    MessagingService.sharedInstance.selectedChannel = MessagingService.sharedInstance.channels[0]
                    self.updateWithChannel()
                }else{
                    self.channelNameLbl.text = "No Channels Yet"
                }
            }
        })
    }
    
    @objc func channelSelected(){
        updateWithChannel()
    }
    
    func updateWithChannel() {
        channelNameLbl.text = "#\(MessagingService.sharedInstance.selectedChannel?.channelTitle ?? "Name not found")"
        getMessages()
    }
    
    func getMessages(){
        guard let channelId = MessagingService.sharedInstance.selectedChannel?.id else {return}
        MessagingService.sharedInstance.getAllMessagesForChannel(channelId: channelId) { (success) in
            if success {
                print("succesfully got messages for a selected channel")
            }else{
                print("failed to get messages for a selected channel.")
            }
        }
        
    }
    
    //MARK:- IBActions
    
    @IBAction func sendBtnTapped(_ sender: Any) {
        
        if AuthService.sharedInstance.isLoggedIn {
            guard let selectedChannel = MessagingService.sharedInstance.selectedChannel else {return}
            guard let messageBody = messageTxtFld.text, messageBody != "" else {return}
            
            SocketService.sharedInstance.addMessage(messageBody: messageBody, userId: UserDataService.sharedInstance.id, channelId: selectedChannel.id, completion: { (success) in
                if success {
                    self.messageTxtFld.text = ""
                    self.view.endEditing(true)
                    
                }else{
                    print("sending message failed")
                }
            })
        }
        
    }
    
    
}

