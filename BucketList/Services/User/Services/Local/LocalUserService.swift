//
//  LocalUserService.swift
//  BucketList
//
//  Created by Kiran on 16/12/25.
//


protocol LocalUserService {
    func saveCurrentUserToFileManager(user: UserModel) throws
    func getCurrentUser() -> UserModel?
}