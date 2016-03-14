//
//  UserLoggedInCondition.swift
//
//  Created by Nicolas Purita
//

import UIKit

struct UserLoggedInCondition: OperationCondition {
    
    static let name = "User Logged In"
    static let isMutuallyExclusive = false
    
    func dependencyForOperation(operation: Operation) -> NSOperation? {
        return nil
    }
    
    func evaluateForOperation(operation: Operation, completion: OperationConditionResult -> Void) {
        if Credentials.sharedInstance.isLogged() {
            completion(.Satisfied)
        } else {
            let error = NSError(code: .ConditionFailed, userInfo: [
                OperationConditionKey: "User is not logged in"
            ])
            completion(.Failed(error))
        }
    }
}