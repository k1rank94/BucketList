//
//  CategoriesModel.swift
//  BucketList
//
//  Created by Kiran on 14/07/25.
//

import Foundation

struct Category: Identifiable, Codable, Equatable {
    var id: String
    var name: String
    var imageString: String
    var isPredefined: Bool
    var isCreatedByUserId: String? // "Will be nil for predefined"
    
    static let mocks: [Category] = [
        Category(id: "1", name: "Adventure", imageString: "mountain.2.fill", isPredefined: true, isCreatedByUserId: nil),
        Category(id: "2", name: "Travel", imageString: "airplane", isPredefined: true, isCreatedByUserId: nil),
        Category(id: "3", name: "Fitness", imageString: "figure.run", isPredefined: true, isCreatedByUserId: nil),
        Category(id: "4", name: "Learning", imageString: "book.fill", isPredefined: true, isCreatedByUserId: nil),
        Category(id: "5", name: "Career", imageString: "briefcase.fill", isPredefined: true, isCreatedByUserId: nil),
        Category(id: "6", name: "Creative", imageString: "paintbrush.fill", isPredefined: true, isCreatedByUserId: nil),
        Category(id: "7", name: "Relationships", imageString: "heart.fill", isPredefined: true, isCreatedByUserId: nil),
        Category(id: "8", name: "Personal Growth", imageString: "leaf.fill", isPredefined: true, isCreatedByUserId: nil)
    ]
}
