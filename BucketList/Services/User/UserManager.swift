//
//  UserManager.swift
//  BucketList
//
//  Created by Kiran on 08/12/25.
//

import Foundation

@MainActor
@Observable
class UserManager {
    
    let remoteUserService: RemoteUserService
    let localUserService: LocalUserService
    
    private(set) var currentUser: UserModel?
    private var listenerTask: Task<Void, Never>?
    
    init(service: UserServices) {
        self.remoteUserService = service.remoteService
        self.localUserService = service.localService
        self.currentUser = getCurrentUser()
        print("Fetched current user locally: \(String(describing: currentUser))")
        print(NSHomeDirectory())
    }
    
    func saveUser(authInfo: UserAuthInfo, isNewUser: Bool) throws {
        let appVersion = isNewUser ? Utilities.appVersion : nil
        let userModel = UserModel(authInfo: authInfo, firstDownloadedVersion: appVersion)
        try remoteUserService.saveUser(user: userModel, isNewUser: isNewUser)
        startListening(userId: userModel.id)
    }
    
    func startListening(userId: String) {
        // Cancel any existing listener before starting a new one
        stopListening()
        
        listenerTask = Task {
            do {
                for try await user in remoteUserService.streamUser(userId: userId) {
                    self.currentUser = user
                    print("Successfully started listening to user \(String(describing: self.currentUser?.id))")
                    saveCurrentUserLocally()
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
        stopListening()
        currentUser = nil
    }
    
    func deleteUser() throws {
        let userId = try getCurrentUserId()
        remoteUserService.deleteUser(with: userId)
    }
    
    func getCurrentUser() -> UserModel? {
        localUserService.getCurrentUser()
    }
    
    func getCurrentUserId() throws -> String {
        guard let userId = currentUser?.id else {
            throw UserManagerError.noUserId
        }
        
        return userId
    }
    
    func markOnboardingCompleted(as status: Bool, for userId: String) {
        remoteUserService.markOnboardingCompleted(as: status, for: userId)
    }
    
    func saveCurrentUserLocally() {
        guard let currentUser else {
            print("No user to save locally")
            return
        }
        do {
            try localUserService.saveCurrentUserToFileManager(user: currentUser)
        } catch {
            print("Failed to save user to file manager with error: \(error)")
        }
    }
    
    enum UserManagerError: LocalizedError {
        case noUserId
    }
}

