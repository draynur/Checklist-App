//
//  User.swift
//  Checklist App
//
//  Created by user931069 on 5/8/21.
//

import Foundation

class User {
    
    var uid: String
    var email: String?
    var displayName: String?
    
    init(uid: String, displayName: String?, email: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
}
