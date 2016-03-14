//
//  LoginOperation.swift
//
//  Created by Nicolas Purita
//

import UIKit

class LoginOperation: GroupOperation {

    let loginOperation: URLSessionTaskOperation
    
    init(username: String, password: String, completionHandler: () -> Void) {
        
        let url = NSURL(string: "http://localhost:9090/login")!
        let task = NSURLSession.sharedSession().downloadTaskWithURL(url) { url, response, error in
            // TODO: Save the AccessToken on the Keychain
        }
        
        self.loginOperation = URLSessionTaskOperation(task: task)
        
        let reachibilityCondition = ReachabilityCondition(host: url)
        loginOperation.addCondition(reachibilityCondition)
        
        let networkObserver = NetworkObserver()
        loginOperation.addObserver(networkObserver)

        let finishedOperation = NSBlockOperation(block: completionHandler)
        finishedOperation.addDependency(loginOperation)
        
        super.init(operations: [loginOperation, finishedOperation])
        
        
        name = "Login Operation"
    }
    
    override func operationDidFinish(operation: NSOperation, withErrors errors: [NSError]) {
        if let _ = errors.first where operation == loginOperation {
            // TODO: Print the error on login
        }
    }
}
