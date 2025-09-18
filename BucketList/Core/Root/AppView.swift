//
//  AppView.swift
//  BucketList
//
//  Created by Kiran on 08/07/25.
//

import SwiftUI

struct AppView: View {
    @State var appState: AppState = AppState()
    @Environment(\.authService) private var authService
    
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
        .onAppear {
            checkUserStatus()
        }
    }
    
    private func checkUserStatus()  {
        Task {
            if let userAuthInfo = await authService.getCurrentUser() {
                print("Signed in with existing anonymous user", userAuthInfo.uid)
            } else {
                do {
                     let userAuthInfo = try await authService.signInAnonymously()
                } catch {
                    print("Failed to sign in user anonymously with error - \(error)")
                }
            }
        }
    }
}

extension EnvironmentValues {
    @Entry var authService = FirebaseAuthService()
}

#Preview {
    AppView()
}
