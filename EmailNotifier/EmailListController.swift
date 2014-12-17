//
//  AppController.swift
//  EmailNotifier
//
//  Created by Vitaliy.Ladan on 07.12.14.
//  Copyright (c) 2014 Vitaliy.Ladan. All rights reserved.
//

import Cocoa

class EmailListController: NSObject {
    
    @IBOutlet weak var contentView: NSView!
    @IBOutlet weak var emailTableView: NSTableView!
    @IBOutlet weak var noEmailTextField: NSTextField!
    
    var emailTableViewContents: NSMutableArray!
    
    var aboutController: AboutController!
    var settingController: SettingController!
    
    override func awakeFromNib() {
        initEmailListView()
        fillTableContents()
        showEmailList()
    }
    
    func initEmailListView() {
        // Painting content view wite color
        contentView.wantsLayer = true
        contentView.layer?.backgroundColor = NSColor.whiteColor().CGColor
        
        // Placing noEmailTextField in the middle of the contentView
        noEmailTextField.frame.origin.x = (contentView.frame.width - noEmailTextField.frame.width) / 2
        noEmailTextField.frame.origin.y = (contentView.frame.height - noEmailTextField.frame.height) / 2
    }
    
    func showEmailList() {
        contentView.addSubview(emailTableView)
        emailTableView.frame = contentView.bounds
        
//        contentView.addSubview(noEmailTextField)
    }
    
    func fillTableContents() -> NSMutableArray {
        
        emailTableViewContents = NSMutableArray()
        
        let emailEntity = EmailEntity()
        emailEntity.sender = "sender.sender@gmail.ru"
        emailEntity.date = NSDate()
        emailEntity.subject = "Learning the Swift programming language"
        emailTableViewContents.addObject(emailEntity)
        
        let emailEntity2 = EmailEntity()
        emailEntity2.sender = "test.test@gmail.ru"
        emailEntity2.date = NSDate()
        emailEntity2.subject = "Weekend photographs"
        emailTableViewContents.addObject(emailEntity2)
        
        return emailTableViewContents!
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> NSInteger {
        if emailTableViewContents == nil {
            return 0
        }
        return emailTableViewContents.count
    }
    
    func tableView(tableView: NSTableView!, viewForTableColumn tableColumn: NSTableColumn!, row: NSInteger) -> NSView! {
        if let contents = emailTableViewContents {
            let emailEntity = contents[row] as EmailEntity
            if let identifier = tableColumn.identifier {
                if identifier == "MainCell" {
                    if let cellViewObj: AnyObject = tableView.makeViewWithIdentifier("MainCell", owner: self) {
                        let cellView = cellViewObj as EmailTableCellView
                        cellView.senderTextField?.stringValue = emailEntity.sender!
                        
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
                        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
                        dateFormatter.doesRelativeDateFormatting = true
                        cellView.dateTextField?.stringValue = dateFormatter.stringFromDate(emailEntity.date)
                        
                        cellView.subjectTextField?.stringValue = emailEntity.subject!
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
}

