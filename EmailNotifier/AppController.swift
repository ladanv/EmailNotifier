//
//  AppController.swift
//  EmailNotifier
//
//  Created by Vitaliy.Ladan on 07.12.14.
//  Copyright (c) 2014 Vitaliy.Ladan. All rights reserved.
//

import Cocoa

class AppController: NSObject {
    
    @IBOutlet weak var emailListPopover: NSPopover!
    
    var statusItem : NSStatusItem!
    var isEmailListPopoverVisible = false
    
    override func awakeFromNib() {
        initStatusItem()
    }
    
    func initStatusItem() {
        statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
        statusItem.image = NSImage(named: "Gray-Mailbox-32")
        statusItem.highlightMode = false
        statusItem.target = self
        statusItem.action = "togglePopover:"
    }
    
    func togglePopover(sender: AnyObject) {
        if isEmailListPopoverVisible {
            isEmailListPopoverVisible = false
            emailListPopover.close()
        } else {
            isEmailListPopoverVisible = true
            emailListPopover.showRelativeToRect(sender.bounds, ofView: statusItem.button!, preferredEdge: NSMaxYEdge)
        }
    }
    
}