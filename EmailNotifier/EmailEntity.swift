//
//  EmailEntity.swift
//  EmailNotifier
//
//  Created by Vitaliy.Ladan on 10.12.14.
//  Copyright (c) 2014 Vitaliy.Ladan. All rights reserved.
//

class EmailEntity: NSObject {
    var sender: String!
    var date: NSDate!
    var subject: String!
    var uid: UInt64!
    
    override init() {
    }
    
    init(message: MCOIMAPMessage) {
        super.init()
        self.initWithMessage(message)
    }
    
    func initWithMessage(message: MCOIMAPMessage) {
        if let sender = message.header?.sender?.displayName {
            self.sender = sender
        } else if let sender = message.header?.from?.displayName {
            self.sender = sender
        } else {
            self.sender = "No sender"
        }
        if let subject = message.header?.subject {
            self.subject = subject
        } else {
            self.subject = "No subject"
        }
        date = message.header.date
        uid = UInt64(message.uid)
    }
}
