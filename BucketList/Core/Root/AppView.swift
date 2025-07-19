//
//  AppView.swift
//  BucketList
//
//  Created by Kiran on 08/07/25.
//

import SwiftUI

struct AppView: View {
    @State var appState: AppState = AppState()
    
    var body: some View {
        
        AppViewBuilder(
            isUserLoggedIn: appState.isUserLoggedIn,
            welcomeView: {
                WelcomeView()
                    .transition(.move(edge: .leading))
            },
            tabbarView: {
                TabbarView()
                    .transition(.move(edge: .trailing))
            }
        )
        .animation(.default, value: appState.isUserLoggedIn)
        .environment(appState)
    }
}

#Preview {
    AppView()
}
