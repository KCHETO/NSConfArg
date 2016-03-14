//
//  ExpirationTokenCondition.swift
//  XapoCards
//
//  Created by Nicolas Purita on 8/10/15.
//  Copyright © 2015 Xapo. All rights reserved.
//

import UIKit

private let TokenExpirationQueue = OperationQueue()
private let tokenExpirationThreshold = NSTimeInterval(60 * 5)

private enum TokenExpirationResult {
    case NotExpire
    case Updated
    case UpdateWithError(NSError)
    case DontExistExpirationDate
}

class ExpirationTokenCondition: OperationCondition {
    
    static let name = "ExpirationToken"
    static let isMutuallyExclusive = false
    
    func dependencyForOperation(operation: Operation) -> NSOperation? {
        return ExpirationTokenOperation(handler: { _ in })
    }
    
    func evaluateForOperation(operation: Operation, completion: OperationConditionResult -> Void) {
        TokenExpirationQueue.addOperation(ExpirationTokenOperation { result in
            switch result {
            case .Updated, .NotExpire:
                completion(.Satisfied)
                break
            case .UpdateWithError(let requestError):
                let error = NSError(code: .ConditionFailed, userInfo: [
                    OperationConditionKey: self.dynamicType.name,
                    NSUnderlyingErrorKey: requestError
                ])
                completion(.Failed(error))
            case .DontExistExpirationDate:
                let error = NSError(code: .ConditionFailed, userInfo: [
                    OperationConditionKey: self.dynamicType.name,
                    NSUnderlyingErrorKey: "Token doesn't have expiration Date"
                ])
                
                // FIXME. Should I shoot a logout?
                
                completion(.Failed(error))
            }
        })
        
    }
}

private class ExpirationTokenOperation: Operation {
    
    private let handler: TokenExpirationResult -> Void
    
    private init(handler: TokenExpirationResult -> Void) {
        self.handler = handler
        
        super.init()
        
        name = "Expiration Operation"
        
        addCondition(MutuallyExclusive<ExpirationTokenOperation>())
    }
    
    private override func execute() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let expirationDate: NSDate? = userDefaults.objectForKey("token_expiration_date") as? NSDate
        
        if let expiration = expirationDate {
            let interval = NSDate().timeIntervalSinceDate(expiration)
            if interval > (-1 * tokenExpirationThreshold) {
                let tokenExpiration = RefreshTokenOperation { error in
                    guard error == nil else {
                        self.handler(TokenExpirationResult.UpdateWithError(error!))
                        return
                    }
                    self.handler(TokenExpirationResult.Updated)
                    self.finish()
                }
                TokenExpirationQueue.addOperation(tokenExpiration)
            } else {
                handler(.NotExpire)
                finish()
            }
        } else {
            handler(.DontExistExpirationDate)
            finish()
        }
    }
}