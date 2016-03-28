//
//  Sport.swift
//  PhotoList
//
//  Created by Nicolas Purita on 14/3/16.
//  Copyright © 2016 NSConfAR. All rights reserved.
//

import Foundation
import RealmSwift

class Sport: Object {
    dynamic var name: String = ""
    dynamic var imageURL: String = ""
    dynamic var category: String = ""
    
    convenience init(json: [String: AnyObject]) {
        self.init()
        
        self.name = json["name"] as! String
        self.imageURL = json["image_url"] as! String
        self.category = json["category"] as! String
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let sport = object as? Sport {
            if self == sport {
                return true
            }
            
            return self.name == sport.name
        }
        return false
    }
}
