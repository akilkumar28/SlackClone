//
//  GradientVIew.swift
//  SlackClone
//
//  Created by AKIL KUMAR THOTA on 1/10/18.
//  Copyright © 2018 AKIL KUMAR THOTA. All rights reserved.
//

import UIKit

class GradientVIew: UIView {
    
    //MARK:- Properties
    var topColor:UIColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1) {
        didSet{
            self.setNeedsLayout()
        }
    }
    
    var bottomColor:UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) {
        didSet{
            self.setNeedsLayout()
        }
    }
    
    //MARK:- Functions
    override func layoutSubviews() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = [topColor.cgColor,bottomColor.cgColor]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

}
