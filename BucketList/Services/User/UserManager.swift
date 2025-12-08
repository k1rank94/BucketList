//
//  UserManager.swift
//  BucketList
//
//  Created by Kiran on 08/12/25.
//

protocol UserService {
    func saveUser(user: UserModel, isNewUser: Bool) throws
}

import Firebase
import FirebaseFirestore

struct FirebaseUserService : UserService {
    
    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }
    
    func saveUser(user: UserModel, isNewUser: Bool) throws {
        try collection.document(user.id).setData(from: user, merge: true)
    }
}

@MainActor
@Observable
class UserManager {
    
    let service: UserService
    private(set) var currentUser: UserModel?
    
    init(service: UserService) {
        self.service = service
        self.currentUser = nil
    }
    
    func saveUser(authInfo: UserAuthInfo, isNewUser: Bool) throws {
        let appVersion = isNewUser ? Utilities.appVersion : nil
        let userModel = UserModel(authInfo: authInfo, firstDownloadedVersion: appVersion)
        try service.saveUser(user: userModel, isNewUser: isNewUser)
    }
}
