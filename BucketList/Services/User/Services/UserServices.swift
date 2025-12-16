//
//  UserServices.swift
//  BucketList
//
//  Created by Kiran on 16/12/25.
//

import Foundation

protocol UserServices {
    var remoteService: RemoteUserService { get }
    var localService: LocalUserService { get }
}

struct MockUserServices: UserServices {
    let remoteService: RemoteUserService = RemoteMockUserService()
    let localService: LocalUserService = LocalMockUserService()
}

struct ProductionUserServices: UserServices {
    let remoteService: RemoteUserService = FirebaseUserService()
    let localService: LocalUserService = FileManagerUserService()
}
