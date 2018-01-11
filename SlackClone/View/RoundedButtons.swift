//
//  RoundedButtons.swift
//  SlackClone
//
//  Created by AKIL KUMAR THOTA on 1/11/18.
//  Copyright © 2018 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class RoundedButtons: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5.0
    }
}
