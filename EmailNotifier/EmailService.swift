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
    
    init() {
        self.initWithSettingService()
    }
    
    func initWithSettingService() {
        session = MCOIMAPSession()
        if let port = (SettingService.port as String).toInt() {
            session.port = UInt32(port)
        }
        if let host = SettingService.host {
            session.hostname = host
        }
        if let email = SettingService.email {
            session.username = email
        }
        if let password = SettingService.password {
            session.password = password
        }
        session.connectionType = MCOConnectionType.TLS
    }
    
    func fetchUnread(callback: (error: NSError?, messages: [AnyObject]!) -> Void) {
        
        let searchOperation = session.searchExpressionOperationWithFolder(self.folder, expression: MCOIMAPSearchExpression.searchUnread())
        
        searchOperation.start { (err: NSError!, indexSet: MCOIndexSet!) -> Void in
        
            if err != nil {
                callback(error: err, messages: nil)
                return
            }
            if indexSet.count() == 0 {
                return
            }
        
            let fetchOperation = self.session.fetchMessagesOperationWithFolder(self.folder, requestKind: MCOIMAPMessagesRequestKind.Headers, uids: indexSet)
            
            
            fetchOperation.start { (err: NSError!, msgs: [AnyObject]!, vanished: MCOIndexSet!) -> Void in
                callback(error: err, messages: msgs)
            }
        }
    }
    
    func markAsRead(idx: UInt64, callback: (error: NSError) -> Void) {
        
        let saveFlagOperation = session.storeFlagsOperationWithFolder(self.folder, uids: MCOIndexSet(index: idx), kind: MCOIMAPStoreFlagsRequestKind.Add, flags: MCOMessageFlag.Seen)
        
        saveFlagOperation.start { (err: NSError!) -> Void in
            callback(error: err)
        }
        
    }
    
    func markAsDeleted(idx: UInt64, callback: (error: NSError) -> Void) {
       
        let saveFlagOperation = session.storeFlagsOperationWithFolder(self.folder, uids: MCOIndexSet(index: idx), kind: MCOIMAPStoreFlagsRequestKind.Add, flags: MCOMessageFlag.Deleted)
       
        saveFlagOperation.start { (err: NSError!) -> Void in
            callback(error: err)
        }
        
    }
    
    func testConnection() -> Bool {
        return true
    }
    
}