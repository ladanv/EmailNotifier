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
    
    func initWithMessage(message: MCOIMAPMessage) {
        sender = message.header.from.mailbox!
        subject = message.header.subject!
        date = message.header.date!
    }
}
