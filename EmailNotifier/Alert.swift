//
//  Alert.swift
//  EmailNotifier
//
//  Created by Vitaliy.Ladan on 14.01.15.
//  Copyright (c) 2015 Vitaliy.Ladan. All rights reserved.
//

import Cocoa

func showError(#messageText: String, #informativeText: String) {
    let alert = NSAlert()
    alert.alertStyle = .CriticalAlertStyle
    alert.messageText = messageText
    alert.informativeText = informativeText
    alert.runModal()
    //        alert.beginSheetModalForWindow(window!, modalDelegate: nil, didEndSelector: nil, contextInfo: nil)
}