//
//  RemoteUserService.swift
//  BucketList
//
//  Created by Kiran on 16/12/25.
//


protocol RemoteUserService {
    func saveUser(user: UserModel, isNewUser: Bool) throws
    func streamUser(userId: String) -> AsyncThrowingStream<UserModel, Error>
    func deleteUser(with id: String)
    func markOnboardingCompleted(as status: Bool, for userId: String)
}