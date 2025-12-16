//
//  RemoteMockUserService.swift
//  BucketList
//
//  Created by Kiran on 16/12/25.
//


struct RemoteMockUserService: RemoteUserService {
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