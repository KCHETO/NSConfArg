//
//  NSDate+Formatter.swift
//  PhotoList
//
//  Created by Nicolas Purita on 14/3/16.
//  Copyright © 2016 NSConfAR. All rights reserved.
//

import Foundation

public extension NSDate {
    
    public class func dateFrom(date: String, withFormat dateFormat: String) -> NSDate? {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.dateFromString(date)
    }
    
    struct Date {
        static let formatterISO: NSDateFormatter = {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
            return dateFormatter
        }()
    }
    
    
    static func dateFromISO(dateStr: String) -> NSDate? {
        return Date.formatterISO.dateFromString(dateStr)
    }
    
}