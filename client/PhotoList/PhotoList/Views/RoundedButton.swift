//
//  RoundedButton.swift
//  PhotoList
//
//  Created by Nicolas Purita on 13/3/16.
//  Copyright © 2016 NSConfAR. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.masksToBounds = true
        }
    }
    
    var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            self.layer.borderColor = borderColor.CGColor
            self.layer.masksToBounds = true
        }
    }
    
    var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
            self.layer.masksToBounds = true
        }
    }
}
