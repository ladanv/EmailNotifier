//
//  AppDelegate.swift
//  EmailNotifier
//
//  Created by Vitaliy.Ladan on 07.12.14.
//  Copyright (c) 2014 Vitaliy.Ladan. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var emailListPopover: NSPopover!
    
    var statusItem : NSStatusItem!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        initStatusItem()
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }
    
    func initStatusItem() {
        statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
        statusItem.image = NSImage(named: "Gray-Mailbox-32")
        statusItem.highlightMode = false
        statusItem.target = self
        statusItem.action = "togglePopover:"
    }
    
    func togglePopover(sender: AnyObject) {
        emailListPopover.showRelativeToRect(sender.bounds, ofView: statusItem.button!, preferredEdge: NSMaxYEdge)
    }
}

