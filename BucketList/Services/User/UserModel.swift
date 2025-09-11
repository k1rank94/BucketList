//
//  UserModel.swift
//  BucketList
//
//  Created by Kiran K on 10/08/25.
//

import Foundation

struct UserModel: Identifiable {
    let id = UUID()
    let name: String?
    let bucketItemsIds: [UUID]
}
