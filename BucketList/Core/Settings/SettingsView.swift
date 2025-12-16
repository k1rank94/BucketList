//
//  SettingsView.swift
//  BucketList
//
//  Created by Kiran on 14/07/25.
//

import SwiftUI
import SwiftfulUtilities

struct SettingsView: View {
    // MARK: - Dependencies
    @Environment(AppState.self) var appState
    @Environment(AuthManager.self) private var authManager
    @Environment(UserManager.self) private var userManager
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - State
    @State private var isAnonymousUser: Bool = true
    @State private var presentCreateAccountView: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                accountSection
                aboutSection
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                checkUserStatus()
            }
        }
        .sheet(isPresented: $presentCreateAccountView) {
            checkUserStatus()
        } content: {
            CreateAccountView()
                .presentationDetents([.medium])
                .presentationCornerRadius(20)
        }
    }
    
    // MARK: - View Components
    
    private var accountSection: some View {
        Section {
            if isAnonymousUser {
                Button {
                    onSignInButtonPressed()
                } label: {
                    SettingsListRow(
                        icon: "person.crop.circle.badge.plus",
                        title: "Sign In & Save Data",
                        actionType: .primary
                    )
                }
                .accessibilityLabel("Sign in and save data")
                .accessibilityHint("Opens the account creation screen")
            } else {
                Button {
                    onSignOutPressed()
                } label: {
                    SettingsListRow(
                        icon: "rectangle.portrait.and.arrow.right",
                        title: "Log out",
                        actionType: .destructive
                    )
                }
                .accessibilityLabel("Log out")
                
                Button {
                    onDeleteAccountPressed()
                } label: {
                    SettingsListRow(
                        icon: "trash",
                        title: "Delete account",
                        actionType: .destructive
                    )
                }
                .accessibilityLabel("Delete account")
                .accessibilityHint("Permanently deletes your account and data")
            }
        } header: {
            Text("Account")
        }
    }
    
    private var aboutSection: some View {
        Section {
            HStack {
                Text("Version")
                    .font(.subheadline) // Set explicitly to match SettingsListRow
                Spacer()
                Text(appVersion)
                    .font(.subheadline) // Set explicitly to match SettingsListRow
                    .foregroundStyle(.secondary)
            }
            .accessibilityElement(children: .combine)
        } header: {
            Text("About")
        }
    }
    
    // MARK: - Actions
    
    private func checkUserStatus() {
        if let user = authManager.authInfo {
            isAnonymousUser = user.isAnonymous
        }
    }
    
    private func onSignInButtonPressed() {
        presentCreateAccountView = true
    }
    
    private func onSignOutPressed() {
        Task {
            do {
                try await authManager.signOut()
                try userManager.signOutUser()
                changeAppState()
            } catch {
                print("Logout Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func onDeleteAccountPressed() {
        Task {
            do {
                try await authManager.deleteUser()
                try userManager.deleteUser()
                changeAppState()
            } catch {
                print("Delete Account Error: \(error.localizedDescription)")
            }
        }
    }
    
    private func changeAppState() {
        dismiss()
        appState.updateLoginStatus(false)
    }
    
    // MARK: - Helpers
    
    private var appVersion: String {
        guard let version = Utilities.appVersion else {
            return "N/A"
        }
        return "\(version)"
    }
}

#Preview("Anonymous User") {
    SettingsView()
        .environment(AppState(isUserLoggedIn: true))
        .environment(AuthManager(service: MockAuthService(signedInUser: nil, delay: 0)))
        .environment(UserManager(service: MockUserServices()))
}

#Preview("Logged In User") {
    SettingsView()
        .environment(AppState(isUserLoggedIn: true))
        .environment(AuthManager(service: MockAuthService(signedInUser: .mock, delay: 0)))
        .environment(UserManager(service: MockUserServices()))
}


