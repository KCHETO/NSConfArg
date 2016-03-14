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
        let params = [
            "username": username,
            "password": password
        ]
        
        let request = NSMutableURLRequest(URL: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.HTTPMethod = "POST"
        request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params, options: .PrettyPrinted)
        
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
