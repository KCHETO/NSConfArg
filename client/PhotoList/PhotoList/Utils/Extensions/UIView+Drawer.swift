//
//  UIView+Drawer.swift
//  PhotoList
//
//  Created by Nicolas Purita on 14/3/16.
//  Copyright © 2016 NSConfAR. All rights reserved.
//

import UIKit

public enum LinePosition: Int {
    case Bottom = 0
    case Top = 1
    case Left = 2
    case Right = 3
}

public extension UIView {
    
    public func drawLine(position: LinePosition, color: UIColor) -> Void {
        
        let layer = CALayer()
        layer.borderColor = color.CGColor
        layer.borderWidth = 1.0
        
        switch position {
        case .Bottom:
            layer.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 1, CGRectGetWidth(self.frame), 1)
            break
        case .Top:
            layer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 1)
            break
        case .Left:
            layer.frame = CGRectMake(0, 0, 1, CGRectGetHeight(self.frame))
            break
        case .Right:
            layer.frame = CGRectMake(0, CGRectGetWidth(self.frame) - 1, 1, CGRectGetHeight(self.frame))
            break
        }
        
        self.layer.addSublayer(layer)
    }
    
}