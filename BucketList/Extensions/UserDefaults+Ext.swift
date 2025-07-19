//
//  UserDefaults+Ext.swift
//  BucketList
//
//  Created by Kiran on 14/07/25.
//

import Foundation

extension UserDefaults {
    static var isUserLoggedIn: Bool {
        get {
            return standard.bool(forKey: Keys.isUserLoggedIn)
        }
        
        set {
            standard.set(newValue, forKey: Keys.isUserLoggedIn)
        }
    }
}
