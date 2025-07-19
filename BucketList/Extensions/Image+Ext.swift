//
//  Image+Ext.swift
//  BucketList
//
//  Created by Kiran on 08/07/25.
//

import SwiftUI

extension Image {
    
    enum CustomImageNames: String {
        case appIcon = "icon_app"
    }
    
    init(with customImageName: CustomImageNames) {
        self.init(customImageName.rawValue)
    }
}
