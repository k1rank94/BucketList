//
//  CategoriesModel.swift
//  BucketList
//
//  Created by Kiran on 14/07/25.
//

import Foundation

struct CategoryModel {
    let type: String
    let imageString: String
    
    
    static let mockCategories: [CategoryModel] = [
        CategoryModel(type: "Travel the World", imageString: "globe.europe.africa.fill"),
        CategoryModel(type: "Adventure Sports", imageString: "figure.climbing"),
        CategoryModel(type: "Learn a Skill", imageString: "brain.head.profile"),
        CategoryModel(type: "Career Milestone", imageString: "briefcase.fill"),
        CategoryModel(type: "Fitness Goal", imageString: "figure.run"),
        CategoryModel(type: "Personal Growth", imageString: "leaf.fill"),
        CategoryModel(type: "Luxury Experience", imageString: "sparkles"),
        CategoryModel(type: "Give Back", imageString: "hands.sparkles.fill"),
        CategoryModel(type: "Family Goals", imageString: "person.2.fill"),
        CategoryModel(type: "Own a Dream Home", imageString: "house.and.flag.fill")
    ]

}
