//
//  AuthService.swift
//  BucketList
//
//  Created by Kiran on 15/09/25.
//

import Foundation

protocol AuthService: Sendable {
    func addAuthenticatedStateListener(_ attchListener: (any NSObjectProtocol) -> Void) -> AsyncStream<UserAuthInfo?>
    func signInAnonymously() async throws -> (authInfo: UserAuthInfo, isNewUser: Bool)
    func getCurrentUser() -> UserAuthInfo?
    func signInWithApple() async throws -> (authInfo: UserAuthInfo, isNewUser: Bool)
    func signOut() async throws
    func deleteUser() async throws
}
