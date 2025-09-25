//
//  AuthManager.swift
//  BucketList
//
//  Created by Kiran on 25/09/25.
//

import Foundation

@Observable
@MainActor
class AuthManager {
    private(set) var authInfo: UserAuthInfo?
    public var service: AuthService
    private var listener: (any NSObjectProtocol)?
    
    init(auth: UserAuthInfo? = nil, service: AuthService) {
        self.service = service
        self.authInfo = service.getCurrentUser()
        addAuthListener()
    }
    
    func getAuthId() throws -> String {
        guard let uid = authInfo?.uid else {
            throw AuthError.notSignedIn
        }
        return uid
    }
    
    func addAuthListener() {
        Task {
            for await value in service.addAuthenticatedStateListener({ listener in
                self.listener = listener
            }) {
                self.authInfo = value
                print("Successfully added auth listener with \(value?.uid ?? "no uid")")
            }
        }
    }
    
    func signInAnonymously() async throws -> UserAuthInfo? {
        try await service.signInAnonymously()
    }
    
    func signInWithApple() async throws -> UserAuthInfo? {
        try await service.signInWithApple()
    }
    
    func signOut() async throws {
        try await service.signOut()
        authInfo = nil
    }
    
    func deleteUser() async throws {
        try await service.deleteUser()
        authInfo = nil
    }
    
    enum AuthError: LocalizedError {
        case notSignedIn
    }
}
