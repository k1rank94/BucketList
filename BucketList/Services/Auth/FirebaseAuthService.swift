//
//  FirebaseAuthService.swift
//  BucketList
//
//  Created by Kiran on 15/09/25.
//

import Foundation
import FirebaseAuth
import SignInAppleAsync

struct FirebaseAuthService: AuthService {
    
    func getCurrentUser() async -> UserAuthInfo? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        return UserAuthInfo(user: user)
    }
    
    func signInAnonymously() async throws -> UserAuthInfo? {
        let authDataResult = try await Auth.auth().signInAnonymously()
        let result = authDataResult.user
        return UserAuthInfo(user: result)
    }
    
    func signInWithApple() async throws -> UserAuthInfo? {
        let helper = await SignInWithAppleHelper()

        let response = try await helper.signIn()
        
        let credential = OAuthProvider.credential(
            providerID: AuthProviderID.apple,
            idToken: response.token,
            rawNonce: response.nonce
        )
        
        do {
            let result = try await Auth.auth().currentUser?.link(with: credential)
            return result?.asAuthinfo
        } catch let error as NSError {
            let authError = AuthErrorCode(rawValue: error.code)
            switch authError {
            case .providerAlreadyLinked, .credentialAlreadyInUse:
                if let existingCredential = error.userInfo["FIRAuthErrorUserInfoUpdatedCredentialKey"] as? AuthCredential {
                    let result = try await Auth.auth().signIn(with: existingCredential)
                    return result.asAuthinfo
                }
            default:
                break
            }
        }
        
        let result = try await Auth.auth().signIn(with: credential)
        return result.asAuthinfo
    }
    
    func signOut() async throws {
        let firebaseAuth = Auth.auth()
        try firebaseAuth.signOut()
    }
    
    func deleteUser() async throws {
        guard let user = Auth.auth().currentUser else { return }
        try await user.delete()
    }
}

extension AuthDataResult {
    var asAuthinfo: UserAuthInfo? {
        let authInfo = UserAuthInfo(user: user)
        return authInfo
    }
}
