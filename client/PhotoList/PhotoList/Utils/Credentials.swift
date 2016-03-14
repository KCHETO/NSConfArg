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

    var accessToken: String? {
        get {
            return userDefatults.objectForKey(CredentialKey.AccessToken.rawValue) as? String
        }
        set {
            _accessToken = newValue
        }
    }
    
    var expirationDate: NSDate? {
        get {
            return userDefatults.objectForKey(CredentialKey.ExpirationDate.rawValue) as? NSDate
        }
        set {
            _expirationDate = newValue
        }
    }
    
    private let userDefatults = NSUserDefaults.standardUserDefaults()
    private var _accessToken: String? {
        didSet {
            userDefatults.setObject(_accessToken, forKey: CredentialKey.AccessToken.rawValue)
            userDefatults.synchronize()
        }
    }
    
    private var _expirationDate: NSDate? {
        didSet {
            userDefatults.setObject(_expirationDate, forKey: CredentialKey.ExpirationDate.rawValue)
            userDefatults.synchronize()
        }
    }
    
    func isLogged() -> Bool {
        return accessToken != nil
    }
    
}

enum CredentialKey: String {
    case AccessToken = "com.nsconfar.credential.access_token"
    case ExpirationDate = "com.nsconfar.credential.expiration_date"
}