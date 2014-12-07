//
//  EmailService.swift
//  EmailNotifier
//
//  Created by Vitaliy.Ladan on 07.12.14.
//  Copyright (c) 2014 Vitaliy.Ladan. All rights reserved.
//

class EmailService {
    
    private let session = MCOIMAPSession()
    
    init() {
        session.hostname = "imap.gmail.com"
        session.port = 993
        session.username = "username@gmail.com"
        session.password = "password"
        session.connectionType = MCOConnectionType.TLS
    }
    
    func fetchUnread() {
        let searchOperation = session.searchExpressionOperationWithFolder("INBOX", expression: MCOIMAPSearchExpression.searchUnread())
        
        searchOperation.start { (err: NSError!, indexSet: MCOIndexSet!) -> Void in
            
            if err != nil {
                println(err!)
                return
            }
            
            if indexSet.count() == 0 {
                println("indexSet.count() == 0")
                return
            }
            
            println("Found " + indexSet.count().description + " messages | " + indexSet.description)
            
            let fetchOp = self.session.fetchMessagesOperationWithFolder("INBOX", requestKind: MCOIMAPMessagesRequestKind.Headers, uids: indexSet)
            
            fetchOp.start { (err: NSError!, msgs: Array!, vanished: MCOIndexSet!) -> Void in
                println("Fetched " + msgs.count.description)
                msgs.map({ (msg: AnyObject) -> AnyObject in
                    let message = msg as MCOIMAPMessage
                    
                    println("---------------------------")
                    println(message.header.from.mailbox!)
                    println(message.header.subject!)
                    println(message.header.date!)
                    
                    return msg
                })
            }
        }
    }
    
    func markAsRead(indexSet: MCOIndexSet) {
        let saveFlagOperation = session.storeFlagsOperationWithFolder("INBOX", uids: indexSet, kind: MCOIMAPStoreFlagsRequestKind.Add, flags: MCOMessageFlag.Seen)
        saveFlagOperation.start { (error: NSError!) -> Void in
            if error == nil {
                println("Marked as read")
            } else {
                println(error!)
            }
        }
    }
    
    func markAsDeleted(indexSet: MCOIndexSet) {
        let saveFlagOperation = session.storeFlagsOperationWithFolder("INBOX", uids: indexSet, kind: MCOIMAPStoreFlagsRequestKind.Add, flags: MCOMessageFlag.Deleted)
        saveFlagOperation.start { (error: NSError!) -> Void in
            if error == nil {
                println("Marked as deleted")
            } else {
                println(error!)
            }
        }
    }
    
}