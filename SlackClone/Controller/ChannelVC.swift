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
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var profileImageView: RoundedImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        self.revealViewController().rearViewRevealWidth = self.view.frame.width - 60
        
        NotificationCenter.default.addObserver(self, selector: #selector(userStateChanged(_:)), name: NOTIF_USER_DATA_CHANGED, object: nil)
        
        SocketService.sharedInstance.getChannel { (success) in
            if success {
                self.myTableView.reloadData()
            }
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpUser()
    }
    
    //MARK:- Functions
    
    fileprivate func setUpUser() {
        if AuthService.sharedInstance.isLoggedIn {
            self.profileImageView.image = UIImage(named: UserDataService.sharedInstance.avatarName)
            self.loginBtn.setTitle(UserDataService.sharedInstance.name, for: .normal)
            self.profileImageView.backgroundColor = UserDataService.sharedInstance.getAvatarColor(component: UserDataService.sharedInstance.avatarColor)
        }else{
            self.profileImageView.image = UIImage(named: "profileDefault")
            self.loginBtn.setTitle("Login", for: .normal)
            self.profileImageView.backgroundColor = UIColor.clear
        }
    }
    
    @objc func userStateChanged(_ notif:Notification) {
        setUpUser()
    }
    
    //MARK:- IBActions
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        if AuthService.sharedInstance.isLoggedIn{
            
            let profileVC = ProfileViewVC()
            profileVC.modalPresentationStyle = .custom
            present(profileVC, animated: true, completion: nil)
            
        }else{
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }
    
    @IBAction func addChannelBtnPrssd(_ sender: Any) {
        
        let channelVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "addChannelVC") as! ADdChannelVC
        channelVC.modalPresentationStyle = .custom
        present(channelVC, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    @IBAction func unwindFromSignUpVC(sender:UIStoryboardSegue){
        
    }
    
    
    //MARK:- Deint
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}



extension ChannelVC:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessagingService.sharedInstance.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellID) as? ChannelCell {
            let channel = MessagingService.sharedInstance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        }else{
            return ChannelCell()
        }
    }
}









