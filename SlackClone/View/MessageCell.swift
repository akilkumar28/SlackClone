//
//  MessageCell.swift
//  SlackClone
//
//  Created by AKIL KUMAR THOTA on 1/14/18.
//  Copyright © 2018 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var messageBodyLbl: UILabel!
    @IBOutlet weak var profileImgView: RoundedImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Functions
    
    func configureCell(message:Message) {
        self.nameLbl.text = message.userName
        self.messageBodyLbl.text = message.message
        self.profileImgView.image = UIImage(named: message.userAvatar)
        self.profileImgView.backgroundColor = UserDataService.sharedInstance.getAvatarColor(component: message.userAvatarColor)
    }

}
