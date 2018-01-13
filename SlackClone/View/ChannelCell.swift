//
//  ChannelCell.swift
//  SlackClone
//
//  Created by AKIL KUMAR THOTA on 1/13/18.
//  Copyright © 2018 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        if selected {
            self.layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        }else{
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    //MARK:- Functions
    
    func configureCell(channel:Channel) {
        self.textLabel?.text = "#\(channel.channelTitle)"
    }

}
