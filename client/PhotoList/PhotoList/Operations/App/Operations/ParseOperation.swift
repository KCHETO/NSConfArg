//
//  ParseOperation.swift
//  PhotoList
//
//  Created by Nicolas Purita on 14/3/16.
//  Copyright © 2016 NSConfAR. All rights reserved.
//

import Foundation
import RealmSwift

class ParseOperation: Operation {

    private let _realmQueue: dispatch_queue_t
    private let _cacheFile: NSURL

    init(cacheFile: NSURL) {
        self._cacheFile = cacheFile
        
        self._realmQueue = dispatch_queue_create("db", DISPATCH_QUEUE_SERIAL);
        
        super.init()
        
        name = "Parse Operation"
    }

    override func execute() {
        guard let stream = NSInputStream(URL: _cacheFile) else {
            finish()
            return
        }
        
        stream.open()
        
        defer {
            stream.close()
        }
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithStream(stream, options: []) as? [String: AnyObject]
            
            if let features = json?["sports"] as? [[String: AnyObject]] {
                parse(features)
            }
            else {
                finish()
            }
            
        } catch let jsonError as NSError {
            finishWithError(jsonError)
        }
    }
    
    private func parse(sports: [[String: AnyObject]]) {
        let sports = sports.flatMap { Sport(json: $0) }        
        dispatch_async(self._realmQueue) {
            do {
                let db = try Realm()
                try db.write {
                    db.add(sports)
                }
            } catch let error as NSError {
                self.finishWithError(error)
            }
        }
    }
    
}