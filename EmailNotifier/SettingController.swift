//
//  SettingController.swift
//  EmailNotifier
//
//  Created by Vitaliy.Ladan on 16.12.14.
//  Copyright (c) 2014 Vitaliy.Ladan. All rights reserved.
//

import Cocoa
import KeychainAccess

class SettingController: NSWindowController {
    @IBOutlet weak var emailTextField: NSTextField!
    @IBOutlet weak var passwordSecureTextfield: NSSecureTextField!
    @IBOutlet weak var hostTextField: NSTextField!
    @IBOutlet weak var portTextField: NSTextField!
    @IBOutlet weak var intervalPopUpButton: NSPopUpButton!
    
    override func showWindow(sender: AnyObject?) {
        super.showWindow(sender)
        if let email = SettingService.email {
            emailTextField.stringValue = email
        }
        if let password = SettingService.password {
            passwordSecureTextfield.stringValue = password
        }
        if let host = SettingService.host {
            hostTextField.stringValue = host
        }
        if let port = SettingService.port {
            portTextField.stringValue = port
        }
        intervalPopUpButton.selectItemWithTag(SettingService.interval)
    }
    
    @IBAction func applySettings(sender: AnyObject) {
        saveSettings()
        let emailService = EmailService.instance
        emailService.initWithSettingService()
        emailService.testConnection()
    }
    
    func windowWillClose(notification: NSNotification) {
        saveSettings()
    }
    
    func saveSettings() {
        SettingService.email = emailTextField.stringValue
        SettingService.password = passwordSecureTextfield.stringValue
        SettingService.host = hostTextField.stringValue
        SettingService.port = portTextField.stringValue
        SettingService.interval = intervalPopUpButton.selectedTag()
    }
}
