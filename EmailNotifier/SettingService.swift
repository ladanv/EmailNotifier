//
//  SettingService.swift
//  EmailNotifier
//
//  Created by Vitaliy.Ladan on 17.12.14.
//  Copyright (c) 2014 Vitaliy.Ladan. All rights reserved.
//

import KeychainAccess

class SettingService {
    
    class var defaultInterval: Int {
        return 10
    }
       
    class var email: NSString? {
        get {
            return NSUserDefaults.standardUserDefaults().valueForKey("email") as NSString?
        }
        set {
            NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: "email")
        }
    }
    
    class func getPassword() -> FailableOf<String> {
        let keychain = Keychain(service: "com.github.ladanv.emailnotifier")
        return keychain.getStringOrError("emailpassword")
    }
    
    class func setPassword(newValue: String) -> NSError? {
        let keychain = Keychain(service: "com.github.ladanv.emailnotifier")
        return keychain.set(newValue, key: "emailpassword") 
    }
    
    class var host: NSString? {
        get {
            return NSUserDefaults.standardUserDefaults().valueForKey("host") as NSString?
        }
        set {
            NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: "host")
        }
    }
    
    class var port: NSString? {
        get {
            return NSUserDefaults.standardUserDefaults().valueForKey("port") as NSString?
        }
        set {
            NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: "port")
        }
    }
    
    class var interval: Int {
        get {
            if let intervalValue = NSUserDefaults.standardUserDefaults().valueForKey("interval") as? Int {
                return intervalValue
            }
            return defaultInterval
        }
        set {
            NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: "interval")
        }
    }
    
}
