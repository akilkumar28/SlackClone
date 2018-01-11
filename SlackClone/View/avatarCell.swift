//
//  avatarCell.swift
//  SlackClone
//
//  Created by AKIL KUMAR THOTA on 1/11/18.
//  Copyright © 2018 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    
    //MARK:- IBOutlets
    
    @IBOutlet weak var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK:- Functions
    
    func configureCell(number:Int,imageName:String,background:Int) {
        self.cellImageView.image = UIImage(named: "\(imageName)\(number)")
        self.backgroundColor = UIColor.lightGray
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
}
