//
//  AppView.swift
//  BucketList
//
//  Created by Kiran on 08/07/25.
//

import SwiftUI

struct AppView: View {
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    
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
                saveUser(with: userAuthInfo, isNewUser: false)
            } else {
                do {
                    let result = try await authManager.signInAnonymously()
                    print("Anonymous user signed in successfully with uid - \(result.authInfo.uid)")
                    saveUser(with: result.authInfo, isNewUser: result.isNewUser)
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


#Preview("Logged in & Anonymous") {
    AppView(appState: AppState(isUserLoggedIn: true))
        .environment(AuthManager(service: MockAuthService(signedInUser: nil, delay: 0)))
        .environment(UserManager(service: MockUserServices()))
}

#Preview("Logged in && signed with email") {
    AppView(appState: AppState(isUserLoggedIn: true))
        .environment(AuthManager(service: MockAuthService(signedInUser: .mock, delay: 0)))
        .environment(UserManager(service: MockUserServices()))
}

#Preview("Logged Out") {
    AppView(appState: AppState(isUserLoggedIn: false))
        .environment(AuthManager(service: MockAuthService(signedInUser: nil, delay: 0)))
        .environment(UserManager(service: MockUserServices()))
}
