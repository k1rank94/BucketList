//
//  AuthService.swift
//  BucketList
//
//  Created by Kiran on 15/09/25.
//

import Foundation

protocol AuthService {
    func signInAnonymously() async throws -> UserAuthInfo?
    func getCurrentUser() async -> UserAuthInfo?
    func signInWithApple() async throws -> UserAuthInfo?
    func signOut() async throws
    func deleteUser() async throws
}
