//
//  ParseOperation.swift
//  PhotoList
//
//  Created by Nicolas Purita on 14/3/16.
//  Copyright © 2016 NSConfAR. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

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
        print("PARSEANDO EL ARCHIVO")
        do {
            let jsonStr = try String(contentsOfURL: _cacheFile, encoding: NSUTF8StringEncoding)
            if let data = jsonStr.dataUsingEncoding(NSUTF8StringEncoding) {
                let json = JSON(data: data)
                if let sports = json["sports"].array {
                    parse(sports)
                }
            }
            
        } catch let jsonError as NSError {
            print("No se pudo leer el json del archivo: (\(jsonError))")
            finishWithError(jsonError)
        }
    }
    
    private func parse(sports: [JSON]) {
        let sports = sports.flatMap { Sport(json: $0.dictionaryObject!) }
        dispatch_async(self._realmQueue) {
            do {
                let db = try Realm()
                try db.write {
                    db.add(sports)
                }
            } catch let error as NSError {
                self.finishWithError(error)
            }
            self.finish()
        }
    }
    
}