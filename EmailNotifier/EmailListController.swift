//
//  AppController.swift
//  EmailNotifier
//
//  Created by Vitaliy.Ladan on 07.12.14.
//  Copyright (c) 2014 Vitaliy.Ladan. All rights reserved.
//

import Cocoa

class EmailListController: NSObject {
    
    @IBOutlet weak var noEmailView: NSView!
    @IBOutlet weak var emailTableView: NSTableView!
    
    var emailTableViewContents: NSMutableArray!
    
    var aboutController: AboutController!
    var settingController: SettingController!
    
    var initialize = true
    
    override func awakeFromNib() {
        objc_sync_enter(self)
        if initialize {
            initialize = false
            initMainView()
            startEmailCheking()
        }
        objc_sync_exit(self)
    }
    
    func startEmailCheking() {
        // TODO get email cheking interval from user settings
        NSTimer.scheduledTimerWithTimeInterval(15, target: self, selector: "checkEmail", userInfo: nil, repeats: true)
    }
    
    func checkEmail() {
        emailTableViewContents = NSMutableArray()
        let emailService = EmailService.instance
        emailService.fetchUnread { (error, messages) -> Void in
            if let err = error {
                println(err.description)
                return
            }
            for var i = messages.count - 1; i >= 0; i-- {
                if let msg = messages[i] as? MCOIMAPMessage {
                    self.emailTableViewContents.addObject(EmailEntity(message: msg))
                }
            }
            self.emailTableView.reloadData()
            self.showEmailList()
            self.notifyUser()
        }
    }
    
    func notifyUser() {
        if emailTableViewContents != nil && emailTableViewContents.count > 0 {
            NSNotificationCenter.defaultCenter().postNotificationName("notifyUser", object: nil)
        }
    }
    
    func initMainView() {
//      Painting noEmailView white
        noEmailView.wantsLayer = true
        noEmailView.layer?.backgroundColor = NSColor.whiteColor().CGColor
    }
    
    func showEmailList() {
        noEmailView.hidden = emailTableViewContents != nil && emailTableViewContents.count > 0
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> NSInteger {
        if emailTableViewContents == nil {
            return 0
        }
        return emailTableViewContents.count
    }
    
    func tableView(tableView: NSTableView!, viewForTableColumn tableColumn: NSTableColumn!, row: NSInteger) -> NSView! {
        if emailTableViewContents.count == 0 {
            return nil
        }
        if let contents = emailTableViewContents {
            let emailEntity = contents[row] as EmailEntity
            if let identifier = tableColumn.identifier {
                if identifier == "MainCell" {
                    if let cellViewObj: AnyObject = tableView.makeViewWithIdentifier("MainCell", owner: self) {
                        let cellView = cellViewObj as EmailTableCellView
                        cellView.senderTextField.stringValue = emailEntity.sender!
                        
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
                        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
                        dateFormatter.doesRelativeDateFormatting = true
                        cellView.dateTextField.stringValue = dateFormatter.stringFromDate(emailEntity.date)
                        
                        cellView.subjectTextField.stringValue = emailEntity.subject!
                        return cellView
                    }
                }
            }
        }
        return nil
    }
    
    @IBAction func showAboutWindow(sender: AnyObject) {
        if aboutController == nil {
            aboutController = AboutController(windowNibName: "AboutWindow")
        }
        aboutController.showWindow(self)
    }
    
    @IBAction func showSettingWindow(sender: AnyObject) {
        if settingController == nil {
            settingController = SettingController(windowNibName: "SettingWindow")
        }
        settingController.showWindow(self)
    }
    
    @IBAction func reloadEmailList(sender: AnyObject) {
        checkEmail()
    }
    
    @IBAction func removeEmail(sender: AnyObject) {
//        EmailService.markAsDeleted()
    }
    
    @IBAction func markEmailAsRead(sender: AnyObject) {
//        EmailService.markAsRead()
    }
    
    
}

