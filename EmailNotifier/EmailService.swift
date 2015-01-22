//
//  EmailService.swift
//  EmailNotifier
//
//  Created by Vitaliy.Ladan on 07.12.14.
//  Copyright (c) 2014 Vitaliy.Ladan. All rights reserved.
//

class EmailService {
    
    private var session = MCOIMAPSession()
    private let folder = "INBOX"
    
    class var instance: EmailService {
        struct Static {
            static let instance: EmailService = EmailService()
        }
        return Static.instance
    }
    
    func initWithSettingService() -> NSError? {
        session = MCOIMAPSession()
        session.connectionType = MCOConnectionType.TLS
        
        if let port = (SettingService.port as? String)?.toInt() {
            session.port = UInt32(port)
        } else {
            session.port = 993
        }
        if let host = SettingService.host {
            session.hostname = host
        } else {
            session.hostname = "imap.gmail.com"
        }
        if let email = SettingService.email {
            session.username = email
        }
        let failable = SettingService.getPassword()
        if failable.failed {
            println("Error in EmailService:InitWithSettingService -> \(failable.error)")
            return failable.error
        } else {
            session.password = failable.value
        }
        
        return nil
    }
    
    func fetchUnread(callback: (error: NSError?, messages: [AnyObject]?) -> Void) {
        
        let searchOperation = session.searchExpressionOperationWithFolder(self.folder, expression: MCOIMAPSearchExpression.searchUnread())
        
        searchOperation.start { (err: NSError!, indexSet: MCOIndexSet!) -> Void in
        
            if err != nil || indexSet.count() == 0 {
                callback(error: err, messages: nil)
                return
            }
            
            let fetchOperation = self.session.fetchMessagesOperationWithFolder(self.folder, requestKind: MCOIMAPMessagesRequestKind.Headers, uids: indexSet)
            
            fetchOperation.start { (err: NSError!, msgs: [AnyObject]!, vanished: MCOIndexSet!) -> Void in
                callback(error: err, messages: msgs)
            }
        }
    }
    
    func markAsRead(idx: UInt64, callback: (error: NSError?) -> Void) {
        
        let saveFlagOperation = session.storeFlagsOperationWithFolder(self.folder, uids: MCOIndexSet(index: idx), kind: MCOIMAPStoreFlagsRequestKind.Add, flags: MCOMessageFlag.Seen)
        
        saveFlagOperation.start { (err: NSError!) -> Void in
            callback(error: err)
        }
        
    }
    
    func markAsDeleted(idx: UInt64, callback: (error: NSError?) -> Void) {
       
        let saveFlagOperation = session.storeFlagsOperationWithFolder(self.folder, uids: MCOIndexSet(index: idx), kind: MCOIMAPStoreFlagsRequestKind.Add, flags: MCOMessageFlag.Deleted)
       
        saveFlagOperation.start { (err: NSError!) -> Void in
            callback(error: err)
        }
        
    }
    
    func testConnection() -> Bool {
        return true
    }
    
}