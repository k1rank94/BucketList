//
//  UserManager.swift
//  BucketList
//
//  Created by Kiran on 08/12/25.
//

import Firebase
import FirebaseFirestore

protocol UserService {
    func saveUser(user: UserModel, isNewUser: Bool) throws
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(with id: String)
    func markOnboardingCompleted(as status: Bool, for userId: String)
}

struct MockUserService: UserService {
    func saveUser(user: UserModel, isNewUser: Bool) throws {
        // Mock implementation does nothing
    }
    
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error> {
        AsyncThrowingStream { continuation in
            // Immediately finish the stream, as this is a mock
            continuation.finish()
        }
    }
    
    func deleteUser(with id: String) {
        // Mock implementation does nothing
    }
    
    func markOnboardingCompleted(as status: Bool, for userId: String) {
        
    }
}

struct FirebaseUserService : UserService {
    
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

@MainActor
@Observable
class UserManager {
    
    let service: UserService
    private(set) var currentUser: UserModel?
    private var listenerTask: Task<Void, Never>?
    
    init(service: UserService) {
        self.service = service
        self.currentUser = nil
    }
    
    func saveUser(authInfo: UserAuthInfo, isNewUser: Bool) throws {
        let appVersion = isNewUser ? Utilities.appVersion : nil
        let userModel = UserModel(authInfo: authInfo, firstDownloadedVersion: appVersion)
        try service.saveUser(user: userModel, isNewUser: isNewUser)
        startListening(userId: userModel.id)
    }
    
    func startListening(userId: String) {
        // Cancel any existing listener before starting a new one
        stopListening()
        
        listenerTask = Task {
            do {
                for try await user in service.streamUser(userId: userId) {
                    self.currentUser = user
                    print("Successfully started listening to user \(String(describing: self.currentUser?.id))")
                }
            } catch {
                print("Error streaming user: \(error)")
            }
        }
    }
    
    func stopListening() {
        listenerTask?.cancel()
        listenerTask = nil
    }
    
    func signOutUser() throws {
        let userId = try getCurrentUserId()
        stopListening()
        currentUser = nil
    }
    
    func deleteUser() throws {
        let userId = try getCurrentUserId()
        service.deleteUser(with: userId)
    }
    
    func getCurrentUserId() throws -> String {
        guard let userId = currentUser?.id else {
            throw UserManagerError.noUserId
        }
        
        return userId
    }
    
    func markOnboardingCompleted(as status: Bool, for userId: String) {
        service.markOnboardingCompleted(as: status, for: userId)
    }
    
    enum UserManagerError: LocalizedError {
        case noUserId
    }
}
