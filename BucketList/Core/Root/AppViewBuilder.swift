//
//  AppViewBuilder.swift
//  BucketList
//
//  Created by Kiran on 08/07/25.
//

import SwiftUI

struct AppViewBuilder<Welcome: View, Main: View>: View {
    
    let isUserLoggedIn: Bool
    
    @ViewBuilder let welcomeView: () -> Welcome
    @ViewBuilder let tabbarView: () -> Main
    
    var body: some View {
        if isUserLoggedIn {
           tabbarView()
        } else {
            welcomeView()
        }
    }
}
