//
//  AuthService.swift
//  BucketList
//
//  Created by Kiran on 15/09/25.
//

import Foundation

protocol AuthService: Sendable {
    func addAuthenticatedStateListener(_ attchListener: (any NSObjectProtocol) -> Void) -> AsyncStream<UserAuthInfo?>
    func signInAnonymously() async throws -> UserAuthInfo?
    func getCurrentUser() -> UserAuthInfo?
    func signInWithApple() async throws -> UserAuthInfo?
    func signOut() async throws
    func deleteUser() async throws
}
