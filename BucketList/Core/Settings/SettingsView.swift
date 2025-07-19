//
//  SettingsView.swift
//  BucketList
//
//  Created by Kiran on 14/07/25.
//

import SwiftUI

struct SettingsView: View {
    @Environment(AppState.self) var appState
    
    var body: some View {
        NavigationStack {
            List {
                logoutButton
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
    
}

#Preview {
    SettingsView()
        .environment(AppState())
}
