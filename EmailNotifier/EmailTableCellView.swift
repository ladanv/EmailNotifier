//
//  EmailTableCellView.swift
//  EmailNotifier
//
//  Created by Vitaliy.Ladan on 16.12.14.
//  Copyright (c) 2014 Vitaliy.Ladan. All rights reserved.
//

import Cocoa

class EmailTableCellView: NSTableCellView {
    
    @IBOutlet weak var senderTextField: NSTextField!
    @IBOutlet weak var dateTextField: NSTextField!
    @IBOutlet weak var subjectTextField: NSTextField!

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
}
