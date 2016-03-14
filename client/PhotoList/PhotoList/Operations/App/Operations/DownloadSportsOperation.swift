//
//  DownloadSportsOperation.swift
//  PhotoList
//
//  Created by Nicolas Purita on 14/3/16.
//  Copyright © 2016 NSConfAR. All rights reserved.
//

import UIKit

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
        
        let refreshTokenCondition = ExpirationTokenCondition()
        taskOperation.addCondition(refreshTokenCondition)
        
        let reachabilityCondition = ReachabilityCondition(host: url!)
        taskOperation.addCondition(reachabilityCondition)
        
        let networkObserver = NetworkObserver()
        taskOperation.addObserver(networkObserver)
        
        addOperation(taskOperation)
        
    }
    
    private func downloadFinished(data: NSData?, error: NSError?) {
        if let raw = data {
            do {
                try NSFileManager.defaultManager().removeItemAtURL(_cacheFile)
            } catch {}
            
            if !raw.writeToURL(_cacheFile, atomically: true) {
                aggregateError(NSError(domain: "Save on file", code: 1, userInfo: ["error_msg": "Could not save on file"]))
            }
        }
        else if let error = error {
            aggregateError(error)
        }
        else {
            // Do nothing, and the operation will automatically finish.
        }
    }
}
