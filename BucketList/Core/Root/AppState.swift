//
//  AppState.swift
//  BucketList
//
//  Created by Kiran on 14/07/25.
//

import Foundation

@Observable
class AppState {
    private(set) var isUserLoggedIn: Bool = false {
        didSet {
            UserDefaults.isUserLoggedIn = isUserLoggedIn
        }
    }
    
    init(isUserLoggedIn: Bool = UserDefaults.isUserLoggedIn) {
        self.isUserLoggedIn = isUserLoggedIn
    }
    
    func updateLoginStatus(_ isUserLoggedIn: Bool) {
        self.isUserLoggedIn = isUserLoggedIn
    }
}
