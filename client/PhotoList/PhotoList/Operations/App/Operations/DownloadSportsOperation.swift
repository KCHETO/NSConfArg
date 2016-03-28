//
//  DownloadSportsOperation.swift
//  PhotoList
//
//  Created by Nicolas Purita on 14/3/16.
//  Copyright © 2016 NSConfAR. All rights reserved.
//

import UIKit
import SwiftyJSON

class DownloadSportsOperation: GroupOperation {

    private let _cacheFile: NSURL
    
    init(cacheFile: NSURL) {
        self._cacheFile = cacheFile
        super.init(operations: [])
        
        name = "Download Sports"
        
        let url = NSURL(string: "http://localhost:9090/sports")
        let request = NSMutableURLRequest(URL: url!)
        
        if let accessToken = Credentials.sharedInstance.accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            self.downloadFinished(data, error: error)
        }
        
        let taskOperation = URLSessionTaskOperation(task: task)
        
        // Adding conditions
        let refreshTokenCondition = NonExpirationTokenCondition()
        taskOperation.addCondition(refreshTokenCondition)
        
        let loggedInOperation = UserLoggedInCondition()
        taskOperation.addCondition(loggedInOperation)
        
        let reachabilityCondition = ReachabilityCondition(host: url!)
        taskOperation.addCondition(reachabilityCondition)
        
        // Observers
        let networkObserver = NetworkObserver()
        taskOperation.addObserver(networkObserver)
        
        addOperation(taskOperation)
        
    }
    
    private func downloadFinished(data: NSData?, error: NSError?) {
        print("SE TERMINO DE EJECUTAR LA DESCARGA DE DEPORTES")
        if let raw = data {
            do {
                try NSFileManager.defaultManager().removeItemAtURL(_cacheFile)
            } catch {}
            
            do {
                let nsJson = try NSJSONSerialization.JSONObjectWithData(raw, options: NSJSONReadingOptions.AllowFragments)
                let json = JSON(nsJson)
                if let jsonAsStr = json.rawString() {
                    
                    try jsonAsStr.writeToURL(_cacheFile, atomically: false, encoding: NSUTF8StringEncoding)
                    finish()
                }
            } catch {
                print("No se pudo guardar en el archivo")
                finishWithError(NSError(domain: "Save on file", code: 1, userInfo: ["error_msg": "Could not save on file"]))
            }
        }
        else if let error = error {
            finishWithError(error)
        }
        else {
            // Do nothing, and the operation will automatically finish.
        }
    }
}
