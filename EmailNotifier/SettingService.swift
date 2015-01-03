//
//  SettingService.swift
//  EmailNotifier
//
//  Created by Vitaliy.Ladan on 17.12.14.
//  Copyright (c) 2014 Vitaliy.Ladan. All rights reserved.
//

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
            return "***"
        }
        set {
            
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
    
}
