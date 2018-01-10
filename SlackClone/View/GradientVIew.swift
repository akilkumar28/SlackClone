//
//  GradientVIew.swift
//  SlackClone
//
//  Created by AKIL KUMAR THOTA on 1/10/18.
//  Copyright © 2018 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

@IBDesignable
class GradientVIew: UIView {

    @IBInspectable var topColor:UIColor = UIColor.red {
        didSet{
            self.layoutIfNeeded()
        }
    }
    
    @IBInspectable var bottomColor:UIColor = UIColor.black {
        didSet{
            self.layoutIfNeeded()
        }
    }
    
    override func layoutSubviews() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = [topColor.cgColor,bottomColor.cgColor]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

}
