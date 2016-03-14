//
//  Credentials.swift
//  PhotoList
//
//  Created by Nicolas Purita on 13/3/16.
//  Copyright © 2016 NSConfAR. All rights reserved.
//

import Foundation

// This class should be on the Keychain
class Credentials {
    
    static let sharedInstance = Credentials()

    let userDefatults = NSUserDefaults.standardUserDefaults()
    
    var accessToken: String? {
        didSet {
            userDefatults.setObject(accessToken, forKey: CredentialKey.AccessToken.rawValue)
            userDefatults.synchronize()
        }
    }
    
    var expirationDate: NSDate? {
        didSet {
            userDefatults.setObject(expirationDate, forKey: CredentialKey.ExpirationDate.rawValue)
            userDefatults.synchronize()
        }
    }
    
    func isLogged() -> Bool {
        return self.accessToken != nil
    }
    
}

private enum CredentialKey: String {
    case AccessToken = "com.nsconfar.credential.access_token"
    case ExpirationDate = "com.nsconfar.credential.expiration_date"
}