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
    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var currentIsTypingLbl: UILabel!
    
    
    //MARK:- Properties
    
    
    //MARK:- Default methods
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTableView.estimatedRowHeight = 110
        messageTableView.rowHeight = UITableViewAutomaticDimension
        sendBtn.isHidden = true
        messageTableView.delegate = self
        messageTableView.dataSource = self
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
        
        SocketService.sharedInstance.getMessage { (newMessage) in
            if newMessage.channelID == MessagingService.sharedInstance.selectedChannel?.id && AuthService.sharedInstance.isLoggedIn {
                MessagingService.sharedInstance.messages.append(newMessage)
                self.messageTableView.reloadData()
                if MessagingService.sharedInstance.messages.count > 0 {
                    let indexPath = IndexPath(row: (MessagingService.sharedInstance.messages.count) -  1, section: 0)
                    self.messageTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)            }
            }
            
            SocketService.sharedInstance.getTypingusers { (typingUsers) in
                var names = ""
                var numberOfTypers = 0
                guard let currentChannelId = MessagingService.sharedInstance.selectedChannel?.id else {return}
                for (user,id) in typingUsers {
                    if user != UserDataService.sharedInstance.name && currentChannelId == id {
                        if names == "" {
                            names = user
                        }else{
                            names = "\(names), \(user)"
                        }
                        numberOfTypers += 1
                    }
                }
                
                if numberOfTypers > 0 && AuthService.sharedInstance.isLoggedIn {
                    var verb = "is"
                    if numberOfTypers > 1 {
                        verb = "are"
                    }
                    self.currentIsTypingLbl.text = "\(names) \(verb) typing a message..."
                }else{
                    self.currentIsTypingLbl.text = ""
                }
            }
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
            self.messageTableView.reloadData()
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
                self.messageTableView.reloadData()
                if MessagingService.sharedInstance.messages.count > 0 {
                    self.messageTableView.scrollToRow(at: IndexPath(row: MessagingService.sharedInstance.messages.count - 1, section: 0), at: .bottom, animated: true)
                }
                
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
                    guard let channelId = MessagingService.sharedInstance.selectedChannel?.id else {return}
                    SocketService.sharedInstance.socket.emit("stopType", UserDataService.sharedInstance.name,channelId)
                }else{
                    print("sending message failed")
                }
            })
        }
        
    }
    
    @IBAction func editingChanged(_ sender: UITextField) {
        guard let channelId = MessagingService.sharedInstance.selectedChannel?.id else {return}
        if messageTxtFld.text == "" {
            sendBtn.isHidden = true
                SocketService.sharedInstance.socket.emit("stopType", UserDataService.sharedInstance.name,channelId)
        }else{
            sendBtn.isHidden = false
            SocketService.sharedInstance.socket.emit("startType", UserDataService.sharedInstance.name,channelId)
        }
    }
    
    
    //MARK:- Deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension ChatVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessagingService.sharedInstance.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: messageCellID) as? MessageCell {
            let message = MessagingService.sharedInstance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        }else{
            return MessageCell()
        }
    }   
}
