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
    @Environment(UserManager.self) private var userManager
    
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
    
    private func checkUserStatus() {
        Task {
            if let userAuthInfo = authManager.authInfo {
                print("Signed in with existing anonymous user", userAuthInfo.uid)
                saveUser(with: userAuthInfo, isNewUser: true)
            } else {
                do {
                    let result = try await authManager.signInAnonymously()
                    print("Anonymous user signed in successfully with uid - \(result.authInfo.uid)")
                    saveUser(with: result.authInfo, isNewUser: false)
                } catch {
                    print("Failed to sign in user anonymously with error - \(error)")
                }
            }
        }
    }
    
    private func saveUser(with authInfo: UserAuthInfo, isNewUser: Bool) {
        do {
            try userManager.saveUser(authInfo: authInfo, isNewUser: isNewUser)
        } catch {
            print("Failed to save user with error - \(error)")
        }
    }
}


#Preview {
    AppView()
}
