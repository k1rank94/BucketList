//
//  FileManagerUserService.swift
//  BucketList
//
//  Created by Kiran on 16/12/25.
//

import Foundation

struct FileManagerUserService: LocalUserService {
    
    func saveCurrentUserToFileManager(user: UserModel) throws {
        try FileManager.save(user, withName: Constants.FileNames.currentUser)
    }
    
    func getCurrentUser() -> UserModel? {
        try? FileManager.get(Constants.FileNames.currentUser, as: UserModel.self)
    }
}


