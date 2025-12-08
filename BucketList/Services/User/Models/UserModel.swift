//
//  UserModel.swift
//  BucketList
//
//  Created by Kiran K on 10/08/25.
//

import Foundation

struct UserModel: Identifiable, Codable {
    var id: String
    var name: String?
    var email: String?
    var profilePicture: String?
    var creationDate: Date?
    var lastSignedDate: Date?
    var firstDownloadedVersion: String?
    
    init(id: String, name: String? = nil, email: String? = nil, profilePicture: String? = nil, creationDate: Date?, lastSignedDate: Date? = nil, firstDownloadedVersion: String?) {
        self.id = id
        self.name = name
        self.email = email
        self.profilePicture = profilePicture
        self.creationDate = creationDate
        self.lastSignedDate = lastSignedDate
        self.firstDownloadedVersion = firstDownloadedVersion
    }
    
    init(authInfo: UserAuthInfo, firstDownloadedVersion: String?) {
        self.id = authInfo.uid
        self.email = authInfo.email
        self.creationDate = authInfo.creationDate
        self.lastSignedDate = authInfo.lastLoginDate
        self.firstDownloadedVersion = firstDownloadedVersion
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case profilePicture = "profile_picture"
        case creationDate = "creation_date"
        case lastSignedDate = "last_signed_date"
        case firstDownloadedVersion = "first_downloaded_version"
    }
}
