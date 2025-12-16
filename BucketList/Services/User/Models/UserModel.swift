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
    var isOnboardingCompleted: Bool?
    
    init(id: String, name: String? = nil, email: String? = nil, profilePicture: String? = nil, creationDate: Date?, lastSignedDate: Date? = nil, firstDownloadedVersion: String?) {
        self.id = id
        self.name = name
        self.email = email
        self.profilePicture = profilePicture
        self.creationDate = creationDate
        self.lastSignedDate = lastSignedDate
        self.firstDownloadedVersion = firstDownloadedVersion
        self.isOnboardingCompleted = nil
    }
    
    init(authInfo: UserAuthInfo, firstDownloadedVersion: String?) {
        self.init(
            id: authInfo.uid,
            email: authInfo.email,
            creationDate: authInfo.creationDate,
            lastSignedDate: authInfo.lastLoginDate,
            firstDownloadedVersion: firstDownloadedVersion
        )
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case profilePicture = "profile_picture"
        case creationDate = "creation_date"
        case lastSignedDate = "last_signed_date"
        case firstDownloadedVersion = "first_downloaded_version"
        case isOnboardingCompleted = "is_onboarding_completed"
    }
}

#if DEBUG
extension UserModel {
    
    static var mock: UserModel {
        UserModel(
            id: "mock-user-123",
            name: "Mock User",
            email: "test@example.com",
            profilePicture: nil,
            creationDate: Date().addingTimeInterval(-86400 * 10),
            lastSignedDate: Date(),
            firstDownloadedVersion: "1.0.0"
        )
    }
    
    static var mockNewUser: UserModel {
        UserModel(
            id: "mock-new-789",
            name: nil,
            email: "new@example.com",
            profilePicture: nil,
            creationDate: Date(),
            lastSignedDate: Date(),
            firstDownloadedVersion: "1.2.0"
        )
    }
}
#endif
