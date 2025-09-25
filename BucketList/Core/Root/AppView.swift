//
//  AppView.swift
//  BucketList
//
//  Created by Kiran on 08/07/25.
//

import SwiftUI

struct AppView: View {
    @State var appState: AppState = AppState()
    @Environment(AuthManager.self) private var authManager
    
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
        .onChange(of: appState.isUserLoggedIn) { oldValue, newValue in
            if !newValue {
                checkUserStatus()
            }
        }
    }
    
    private func checkUserStatus()  {
        Task {
            if let userAuthInfo = await authManager.authInfo {
                print("Signed in with existing anonymous user", userAuthInfo.uid)
            } else {
                do {
                     let userAuthInfo = try await authManager.signInAnonymously()
                    print("Anonymous user signed in successfully with uid - \(String(describing: userAuthInfo?.uid))")
                } catch {
                    print("Failed to sign in user anonymously with error - \(error)")
                }
            }
        }
    }
}


#Preview {
    AppView()
}
