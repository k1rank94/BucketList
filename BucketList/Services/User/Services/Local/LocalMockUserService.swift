//
//  LocalMockUserService.swift
//  BucketList
//
//  Created by Kiran on 16/12/25.
//


struct LocalMockUserService: LocalUserService {
    func saveCurrentUserToFileManager(user: UserModel) throws {
        // No-op for mock
    }
    
    func getCurrentUser() -> UserModel? {
        // Always return nil for mock
        return .mock
    }
}
