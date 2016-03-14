//
//  UIStoryboard+Initialization.swift
//  PhotoList
//
//  Created by Nicolas Purita on 14/3/16.
//  Copyright © 2016 NSConfAR. All rights reserved.
//

import UIKit

public extension UIStoryboard {
    
    public class func initialize(storyboard: String) -> UIViewController? {
        return UIStoryboard(name: storyboard, bundle: NSBundle.mainBundle()).instantiateInitialViewController()
    }
    
    public class func initialize(viewControllerId: String, storyboardName: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: NSBundle.mainBundle())
        let viewController = storyboard.instantiateViewControllerWithIdentifier(viewControllerId)
        
        return viewController
    }
    
}
