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
    
    init(completionHandler: () -> Void ) {
        
        let cachesFolder = try! NSFileManager.defaultManager().URLForDirectory(.CachesDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
        let cacheFile = cachesFolder.URLByAppendingPathComponent("sports.json")
        
        _downloadOperation = DownloadSportsOperation(cacheFile: cacheFile)
        _parseOperation = ParseOperation(cacheFile: cacheFile)
        
        let finishOperation = NSBlockOperation(block: completionHandler)
        
        _parseOperation.addDependency(_downloadOperation)
        finishOperation.addDependency(_parseOperation)
        
        super.init(operations: [_downloadOperation, _parseOperation, finishOperation])
        
        name = "Get Sports"
    }

}
