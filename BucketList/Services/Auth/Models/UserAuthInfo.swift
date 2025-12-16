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

#if DEBUG
extension UserAuthInfo {
    
    static var mock: UserAuthInfo {
        UserAuthInfo(
            uid: "mock-user-123",
            isAnonymous: false,
            email: "test@example.com",
            creationDate: Date().addingTimeInterval(-86400 * 10), // Created 10 days ago
            lastLoginDate: Date()
        )
    }
    
    static var mockAnonymous: UserAuthInfo {
        UserAuthInfo(
            uid: "mock-anon-456",
            isAnonymous: true,
            email: nil,
            creationDate: Date(),
            lastLoginDate: Date()
        )
    }
}
#endif
