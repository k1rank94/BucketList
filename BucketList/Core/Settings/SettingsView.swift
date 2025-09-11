//
//  SettingsView.swift
//  BucketList
//
//  Created by Kiran on 14/07/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(AppState.self) var appState
    @State private var isAnonymousUser: Bool = true
    
    var body: some View {
        NavigationStack {
            List {
                accountsSection
            }
            .navigationTitle("Settings")
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
                Text("SignIn & save data")
            } else {
                Text("Logout")
            }
        } header: {
            Text("Accounts")
        }

    }
    
}

#Preview {
    SettingsView()
        .environment(AppState())
}
