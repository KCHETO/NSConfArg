//
//  RefreshTokenOperation.swift
//
//  Created by Nicolas Purita
//

import UIKit

typealias RefreshTokenBlock = NSError? -> Void

class RefreshTokenOperation: GroupOperation {
    
    private let requestOperation: URLSessionTaskOperation
    private let handler: RefreshTokenBlock
    
    init(completionHandler: RefreshTokenBlock) {
        handler = completionHandler
        
        let url = NSURL(string: "http://localhost:9090/refresh_token")!
        let task = NSURLSession.sharedSession().downloadTaskWithURL(url) { url, response, error in
            // TODO: Save the new Token
        }
        
        requestOperation = URLSessionTaskOperation(task: task)
        
        super.init(operations: [requestOperation])
        
        name = "Refresh Token"
    }
    
    internal override func operationDidFinish(operation: NSOperation, withErrors errors: [NSError]) {
        if let first = errors.first {
            handler(first)
        } else {
            handler(nil)
        }
        finish(errors)
    }
}