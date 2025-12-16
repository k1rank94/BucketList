//
//  FirebaseUserService.swift
//  BucketList
//
//  Created by Kiran on 16/12/25.
//

import Firebase
import FirebaseFirestore

struct FirebaseUserService : RemoteUserService {
    
    var collection: CollectionReference {
        Firestore.firestore().collection("users")
    }
    
    func saveUser(user: UserModel, isNewUser: Bool) throws {
        try collection.document(user.id).setData(from: user, merge: true)
    }
    
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error> {
        AsyncThrowingStream { continuation in
            _ = collection.document(userId).addSnapshotListener { snapshot, error in
                if let error = error {
                    continuation.finish(throwing: error)
                    return
                }
                
                guard let snapshot = snapshot, snapshot.exists else {
                    // Handle case where document doesn't exist yet or was deleted
                    // You might want to yield nil or a specific error depending on your logic
                    return
                }
                
                do {
                    let user = try snapshot.data(as: UserModel.self)
                    continuation.yield(user)
                } catch {
                    continuation.finish(throwing: error)
                }
            }
        }
    }
    
    func deleteUser(with id: String) {
        collection.document(id).delete()
    }
    
    func markOnboardingCompleted(as status: Bool, for userId: String) {
        collection.document(userId).updateData([
            UserModel.CodingKeys.isOnboardingCompleted.rawValue : true
        ])
    }
}
