//
//  UserAuthInfo.swift
//  BucketList
//
//  Created by Kiran on 15/09/25.
//

import Foundation

struct UserAuthInfo {
    let uid: String
    let isAnonymous: Bool
    let email: String?
    let creationDate: Date?
    let lastLoginDate: Date?
    
    init(uid: String, isAnonymous: Bool, email: String?, creationDate: Date?, lastLoginDate: Date?) {
        self.uid = uid
        self.isAnonymous = isAnonymous
        self.email = email
        self.creationDate = creationDate
        self.lastLoginDate = lastLoginDate
    }
}
