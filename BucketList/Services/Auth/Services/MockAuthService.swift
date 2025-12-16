//
//  MockAuthService.swift
//  BucketList
//
//  Created by Kiran on 16/12/25.
//

import Foundation

struct MockAuthService: AuthService {
    
    // MARK: - Configuration
    /// The user to return when simulating a logged-in state.
    let mockUser: UserAuthInfo?
    
    /// Simulate network delay to test loading spinners.
    let delay: TimeInterval
    
    /// Helper to determine if we should simulate a successful login or existing session.
    private var isSignedIn: Bool {
        return mockUser != nil
    }
    
    // MARK: - Init
    init(signedInUser: UserAuthInfo? = nil, delay: TimeInterval = 1.0) {
        self.mockUser = signedInUser
        self.delay = delay
    }
    
    // MARK: - AuthService Implementation
    
    func getCurrentUser() -> UserAuthInfo? {
        return mockUser
    }
    
    func addAuthenticatedStateListener(_ attchListener: (any NSObjectProtocol) -> Void) -> AsyncStream<UserAuthInfo?> {
        return AsyncStream { continuation in
            // 1. Immediately yield the current mock state
            continuation.yield(mockUser)
            
            // 2. Satisfy the listener attachment signature with a dummy object
            // (Since we don't have a real Firebase handle to detach later)
            attchListener(NSObject())
            
            // Note: In a more complex mock, you could save this continuation
            // to a class-based backing store to push updates later.
        }
    }
    
    func signInAnonymously() async throws -> (authInfo: UserAuthInfo, isNewUser: Bool) {
        try await simulateNetworkCall()
        
        // Return a fallback mock user if one wasn't injected, or the injected one
        guard let user = mockUser else {
            // Throw an error or return a default dummy if mockUser is nil
            // Assuming you have a way to create a dummy UserAuthInfo.
            // If UserAuthInfo relies strictly on FIRUser, see the note below.
            throw NSError(domain: "MockAuth", code: 404, userInfo: [NSLocalizedDescriptionKey: "No mock user configured"])
        }
        
        return (user, true)
    }
    
    func signInWithApple() async throws -> (authInfo: UserAuthInfo, isNewUser: Bool) {
        try await simulateNetworkCall()
        
        guard let user = mockUser else {
             throw NSError(domain: "MockAuth", code: 404, userInfo: [NSLocalizedDescriptionKey: "No mock user configured"])
        }
        
        return (user, false)
    }
    
    func signOut() async throws {
        try await simulateNetworkCall()
        // In a stateless struct mock, we can't really "clear" the user
        // effectively unless this Service is backed by a Class/Actor.
        // For previews, successful return is usually enough.
    }
    
    func deleteUser() async throws {
        try await simulateNetworkCall()
    }
    
    // MARK: - Helpers
    
    private func simulateNetworkCall() async throws {
        if delay > 0 {
            // Sleep to mimic network latency (nanoseconds)
            try await Task.sleep(nanoseconds: UInt64(delay * 1_000_000_000))
        }
    }
}
