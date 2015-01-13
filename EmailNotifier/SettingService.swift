//
//  SettingService.swift
//  EmailNotifier
//
//  Created by Vitaliy.Ladan on 17.12.14.
//  Copyright (c) 2014 Vitaliy.Ladan. All rights reserved.
//

import KeychainAccess

class SettingService {
       
    class var email: NSString? {
        get {
            return NSUserDefaults.standardUserDefaults().valueForKey("email") as NSString?
        }
        set {
            NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: "email")
        }
    }
    
    // TODO use keychain
    class var password: NSString? {
        get {
            let keychain = Keychain(service: "com.github.ladanv.emailnotifier")
            return keychain["emailpassword"]
        }
        set {
            let keychain = Keychain(service: "com.github.ladanv.emailnotifier")
            keychain["emailpassword"] = newValue
        }
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
            return 5
        }
        set {
            NSUserDefaults.standardUserDefaults().setValue(newValue, forKey: "interval")
        }
    }
    
}
