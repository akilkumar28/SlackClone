//
//  RoundedImageView.swift
//  SlackClone
//
//  Created by AKIL KUMAR THOTA on 1/11/18.
//  Copyright © 2018 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    func setUp(){
        self.layer.cornerRadius = self.bounds.width / 2
        self.clipsToBounds = true
    }

}
