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
    
    let emptyMailboxIcon = "Gray-Mailbox-32"
    let fullMailboxIcon = "Black-Mailbox-32"
    var statusItem : NSStatusItem!
    
    var blingIconCounter = 0
    var blingIconTimer: NSTimer?
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        initStatusItem()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "notifyUser", name: "notifyUser", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "resetStatusIcon", name: "resetStatusIcon", object: nil)
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }
    
    func initStatusItem() {
        statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
        statusItem.image = NSImage(named: emptyMailboxIcon)
        statusItem.highlightMode = false
        statusItem.target = self
        statusItem.action = "togglePopover:"
    }
    
    func togglePopover(sender: AnyObject) {
        emailListPopover.showRelativeToRect(sender.bounds, ofView: statusItem.button!, preferredEdge: NSMaxYEdge)
    }
    
    func notifyUser() {
        if statusItem.image?.name() == emptyMailboxIcon {
            if emailListPopover.shown {
                statusItem.image = NSImage(named: fullMailboxIcon)
                return
            }            
            if let timer = blingIconTimer {
                if !timer.valid {
                    startBlingingIcon()
                }
            } else {
                startBlingingIcon()
            }
        }
    }
    
    func startBlingingIcon() {
        blingIconCounter = 5 * 2 // bling 5 times, 2 times with black icon and 2 times with gray
        blingIconTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "blingIcon", userInfo: nil, repeats: true)
    }
    
    func blingIcon() {
        if blingIconCounter == 0 {
            stopBlingingIcon()
        } 
        let iconName = blingIconCounter % 2 == 0 ? fullMailboxIcon : emptyMailboxIcon
        statusItem.image = NSImage(named: iconName)
        blingIconCounter--
    }
    
    func stopBlingingIcon() {
        if let timer = blingIconTimer {
            timer.invalidate()
        }
    }
    
    func resetStatusIcon() {
        stopBlingingIcon()
        statusItem.image = NSImage(named: emptyMailboxIcon)
    }
}

