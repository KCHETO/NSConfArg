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
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        
        if let accessToken = Credentials.sharedInstance.accessToken {
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            if let _ = error {
                print("Error: \(error!)")
                return
            }
            
            if let json = try! NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves) as? NSDictionary {
                print("Login response data: \(json)")
                
                let accessToken = json["access_token"] as! String
                let expirationDate = NSDate.dateFromISO(json["expire_in"] as! String)
                
                Credentials.sharedInstance.accessToken = accessToken
                Credentials.sharedInstance.expirationDate = expirationDate
            }
        }
        
        requestOperation = URLSessionTaskOperation(task: task)
        
        super.init(operations: [requestOperation])
        
        name = "Refresh Token"
        
        print("Refrescando el token....")
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