//
//  GetSportsOperation.swift
//  PhotoList
//
//  Created by Nicolas Purita on 14/3/16.
//  Copyright © 2016 NSConfAR. All rights reserved.
//

import UIKit

class GetSportsOperation: GroupOperation {

    private let _downloadOperation: DownloadSportsOperation
    private let _parseOperation: ParseOperation
    private let _delayOperation: DelayOperation
    
    init(completionHandler: () -> Void ) {
        
        let cachesFolder = try! NSFileManager.defaultManager().URLForDirectory(.CachesDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
        let cacheFile = cachesFolder.URLByAppendingPathComponent("sports.json")

        _downloadOperation = DownloadSportsOperation(cacheFile: cacheFile)
        _delayOperation = DelayOperation(interval: 0.5)
        _parseOperation = ParseOperation(cacheFile: cacheFile)
        
        let finishOperation = NSBlockOperation(block: completionHandler)
        
        _delayOperation.addDependency(_downloadOperation)
        _parseOperation.addDependency(_delayOperation)
        finishOperation.addDependency(_parseOperation)
        
        super.init(operations: [_downloadOperation, _delayOperation, _parseOperation, finishOperation])
        
        name = "Get Sports"
    }

}
