//
//  DesignableBtn.swift
//  Gamify Version 2
//
//  Created by Brett Goldfine on 7/28/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableBtn: UIButton {
    
    //sets up and loads button at same time
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //constants for button
        let color = UIColor.white
        let disabledColor = color.withAlphaComponent(0.3)
        
        var gradientColor1 = UIColor(red: 100.0 / 255.0, green: 100.0 / 255.0, blue: 100.0 / 255.0, alpha: 1).cgColor
        var gradientColor2 = UIColor(red: 50.0 / 255.0, green: 50.0 / 255.0, blue: 50.0 / 255.0, alpha: 1).cgColor
        
        let btnFont = "Noteworthy"
        let btnWidth = 280
        let btnHeight = 80
        
        //setting up buttons for different tags
        if self.tag == 1 {
            gradientColor1 = UIColor(red: 51.0 / 234.0, green: 234.0 / 255.0, blue: 51.0 / 255.0, alpha: 1).cgColor
            gradientColor2 = UIColor(red: 76.0 / 255.0, green: 137.0 / 255.0, blue: 85.0 / 255.0, alpha: 1).cgColor
        }
        else if self.tag == 2 {
            gradientColor1 = UIColor(red: 86.3 / 255.0, green: 91.8 / 255.0, blue: 20.0 / 255.0, alpha: 1).cgColor
            gradientColor2 = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 0.0 / 255.0, alpha: 1).cgColor
        }
        else if self.tag == 3 {
            gradientColor1 = UIColor(red: 255.0 / 255.0, green: 69.0 / 255.0, blue: 0.0 / 255.0, alpha: 1).cgColor
            gradientColor2 = UIColor(red: 100.0 / 255.0, green: 22.7 / 255.0, blue: 20.8 / 255.0, alpha: 1).cgColor
        }
        
        //setting size and frame origin
        self.frame.size = CGSize(width: btnWidth, height: btnHeight)
        /*self.frame.origin = CGPoint(x: (((superview?.frame.width)! / 2) - (self.frame.width / 2)), y: self.frame.origin.y)*/
        
        //set up border and make corners rounded
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
        self.layer.borderWidth = 3.0
        self.layer.borderColor = color.cgColor
        
        //sets up title
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(disabledColor, for: .disabled)
        self.titleLabel?.font = UIFont(name: btnFont, size: 25)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.setTitle(self.titleLabel?.text?.capitalized, for: .normal)
        
        //sets up button gradient and colors
        let btnGradient = CAGradientLayer()
        btnGradient.frame = self.bounds
        btnGradient.colors = [gradientColor1, gradientColor2]
        btnGradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        btnGradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        btnGradient.frame = self.bounds
        btnGradient.cornerRadius = 5
        self.layer.insertSublayer(btnGradient, at: 0)
        
        //makes it so text isn't vertically uncentered, brings up margin by four pixels, add if you think
        //self.contentEdgeInsets.bottom = 4
        
        
        
        
    }
    
    
}
