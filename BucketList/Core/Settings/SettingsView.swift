//
//  SettingsView.swift
//  BucketList
//
//  Created by Kiran on 14/07/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(AppState.self) var appState
    @Environment(AuthManager.self) private var authManager
    @Environment(\.dismiss) private var dismiss
    @State private var isAnonymousUser: Bool = true
    @State private var presentCreateAccountView: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                accountsSection
            }
            .navigationTitle("Settings")
            .onAppear {
                checkUserStatus()
            }
        }
        .sheet(isPresented: $presentCreateAccountView) {
            print("In closure of create account view")
            checkUserStatus()
        } content: {
            CreateAccountView()
                .presentationDetents([.medium])
                .presentationCornerRadius(20)
        }
    }
    
    private var logoutButton: some View {
        Button {
            onLogoutButtonTapped()
        } label: {
            Text("Log out")
                .foregroundStyle(.red)
        }
    }
    
    private func onLogoutButtonTapped() {
        appState.updateLoginStatus(false)
    }
    
    private var accountsSection: some View {
        Section {
            if isAnonymousUser {
                Button {
                    onSignInButtonPressed()
                } label: {
                    Text("Sign In & save data")
                        .font(.body)
                        .foregroundStyle(.black)
                }

            } else {
                Button {
                    onSignOutPressed()
                } label: {
                    Text("Logout")
                        .font(.body)
                        .foregroundStyle(.red)
                }
                
                Button {
                    onDeleteAccountPressed()
                } label: {
                    Text("Delete account")
                        .font(.body)
                        .foregroundStyle(.red)
                }
            }
        } header: {
            Text("Accounts")
        }
    }
    
    private func checkUserStatus()  {
        Task {
            if let user = authManager.authInfo {
                isAnonymousUser = user.isAnonymous
            }
        }
    }
    
    private func onSignInButtonPressed() {
        presentCreateAccountView = true
    }
    
    private func onSignOutPressed() {
        Task {
            do {
                try await authManager.signOut()
                changeAppState()
            } catch {
                print("Failed to signout with error: %@", error.localizedDescription)
            }
        }
    }
    
    private func onDeleteAccountPressed() {
        Task {
            do {
                try await authManager.deleteUser()
                changeAppState()
            } catch {
                print("Failed to delete account with error: %@", error.localizedDescription)
            }
        }
    }
    
    private func changeAppState() {
        dismiss()
        appState.updateLoginStatus(false)
    }
}

#Preview {
    SettingsView()
        .environment(AppState())
}
