//
//  UserBucketItem.swift
//  BucketList
//
//  Created by Kiran K on 11/09/25.
//

import Foundation

struct UserBucketItem: Identifiable, Codable {
    let id: String
    let categoryId: String
    let title: String
    let description: String?
    let userId: String
    let creationDate: Date
    let targetDate: Date?
    let completionDate: Date?
    let status: BucketListStatus
    var images: [String]?
}

enum BucketListStatus: String, CaseIterable, Codable {
    case dreaming, planning, inProgress, completed
}

extension UserBucketItem {
    static let mocks: [UserBucketItem] = [
        // IN PROGRESS ITEMS
        UserBucketItem(
            id: "item_1",
            categoryId: "adventure",
            title: "Climb Mount Kilimanjaro",
            description: "Trek to the highest peak in Africa. Training 3x per week with hiking boots.",
            userId: "user_123",
            creationDate: Calendar.current.date(byAdding: .month, value: -2, to: Date()) ?? Date(),
            targetDate: Calendar.current.date(byAdding: .month, value: 4, to: Date()),
            completionDate: nil,
            status: .inProgress,
            images: ["kilimanjaro_1.jpg", "training_gear.jpg"]
        ),
        
        UserBucketItem(
            id: "item_2",
            categoryId: "fitness",
            title: "Run a Half Marathon",
            description: "Complete a 13.1 mile race. Currently running 5 miles consistently.",
            userId: "user_123",
            creationDate: Calendar.current.date(byAdding: .month, value: -1, to: Date()) ?? Date(),
            targetDate: Calendar.current.date(byAdding: .month, value: 2, to: Date()),
            completionDate: nil,
            status: .inProgress,
            images: ["running_shoes.jpg"]
        ),
        
        // PLANNING ITEMS
        UserBucketItem(
            id: "item_3",
            categoryId: "travel",
            title: "Backpack Through Southeast Asia",
            description: "3-month journey through Thailand, Vietnam, and Cambodia. Researching routes and budget.",
            userId: "user_123",
            creationDate: Calendar.current.date(byAdding: .weekOfYear, value: -3, to: Date()) ?? Date(),
            targetDate: Calendar.current.date(byAdding: .month, value: 8, to: Date()),
            completionDate: nil,
            status: .planning,
            images: ["asia_map.jpg", "backpack.jpg"]
        ),
        
        UserBucketItem(
            id: "item_4",
            categoryId: "learning",
            title: "Learn Spanish Fluently",
            description: "Reach conversational level for travel and career. Planning to take classes and use apps.",
            userId: "user_123",
            creationDate: Calendar.current.date(byAdding: .weekOfYear, value: -1, to: Date()) ?? Date(),
            targetDate: Calendar.current.date(byAdding: .year, value: 1, to: Date()),
            completionDate: nil,
            status: .planning,
            images: nil
        ),
        
        UserBucketItem(
            id: "item_5",
            categoryId: "career",
            title: "Start My Own Business",
            description: "Launch a small consulting firm. Need to save money and develop business plan.",
            userId: "user_123",
            creationDate: Calendar.current.date(byAdding: .day, value: -10, to: Date()) ?? Date(),
            targetDate: Calendar.current.date(byAdding: .year, value: 2, to: Date()),
            completionDate: nil,
            status: .planning,
            images: ["business_plan.jpg"]
        ),
        
        // DREAMING ITEMS
        UserBucketItem(
            id: "item_6",
            categoryId: "adventure",
            title: "Go Skydiving",
            description: "Tandem jump from 15,000 feet. Overcome my fear of heights.",
            userId: "user_123",
            creationDate: Calendar.current.date(byAdding: .day, value: -5, to: Date()) ?? Date(),
            targetDate: nil,
            completionDate: nil,
            status: .dreaming,
            images: nil
        ),
        
        UserBucketItem(
            id: "item_7",
            categoryId: "creative",
            title: "Write a Novel",
            description: "Fiction book about time travel. Have some character ideas brewing.",
            userId: "user_123",
            creationDate: Calendar.current.date(byAdding: .day, value: -15, to: Date()) ?? Date(),
            targetDate: nil,
            completionDate: nil,
            status: .dreaming,
            images: ["story_notes.jpg"]
        ),
        
        UserBucketItem(
            id: "item_8",
            categoryId: "travel",
            title: "Visit All 7 Continents",
            description: "Epic world exploration goal. So far been to North America and Europe.",
            userId: "user_123",
            creationDate: Calendar.current.date(byAdding: .month, value: -3, to: Date()) ?? Date(),
            targetDate: nil,
            completionDate: nil,
            status: .dreaming,
            images: ["world_map.jpg"]
        ),
        
        // COMPLETED ITEMS
        UserBucketItem(
            id: "item_9",
            categoryId: "learning",
            title: "Learn to Cook Authentic Italian Pasta",
            description: "Master making pasta from scratch. Took a cooking class in Little Italy!",
            userId: "user_123",
            creationDate: Calendar.current.date(byAdding: .month, value: -4, to: Date()) ?? Date(),
            targetDate: Calendar.current.date(byAdding: .month, value: -1, to: Date()),
            completionDate: Calendar.current.date(byAdding: .weekOfYear, value: -2, to: Date()),
            status: .completed,
            images: ["pasta_making.jpg", "finished_dish.jpg"]
        ),
        
        UserBucketItem(
            id: "item_10",
            categoryId: "relationships",
            title: "Reconnect with College Friends",
            description: "Organized a reunion weekend. Amazing to catch up after 5 years!",
            userId: "user_123",
            creationDate: Calendar.current.date(byAdding: .month, value: -6, to: Date()) ?? Date(),
            targetDate: Calendar.current.date(byAdding: .month, value: -2, to: Date()),
            completionDate: Calendar.current.date(byAdding: .month, value: -1, to: Date()),
            status: .completed,
            images: ["reunion_group.jpg"]
        ),
        
        UserBucketItem(
            id: "item_11",
            categoryId: "personal_growth",
            title: "Meditate Daily for 30 Days",
            description: "Built a consistent morning meditation practice. Feel much more centered now.",
            userId: "user_123",
            creationDate: Calendar.current.date(byAdding: .month, value: -3, to: Date()) ?? Date(),
            targetDate: Calendar.current.date(byAdding: .month, value: -1, to: Date()),
            completionDate: Calendar.current.date(byAdding: .weekOfYear, value: -3, to: Date()),
            status: .completed,
            images: nil
        )
    ]
}

