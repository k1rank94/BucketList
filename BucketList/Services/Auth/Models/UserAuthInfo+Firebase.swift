//
//  UserAuthInfo+Firebase.swift
//  BucketList
//
//  Created by Kiran on 15/09/25.
//

import Foundation
import FirebaseAuth

extension UserAuthInfo {
    init(user: User) {
        self.uid = user.uid
        self.isAnonymous = user.isAnonymous
        self.email = user.email
        self.creationDate = user.metadata.creationDate
        self.lastLoginDate = user.metadata.lastSignInDate
    }
}
