//
//  ProfileView.swift
//  BucketList
//
//  Created by Kiran on 11/07/25.
//

import SwiftUI

struct ProfileView: View {
    @State var presentProfileView: Bool = false
    var body: some View {
        NavigationStack {
            Text("Profile")
                .navigationTitle("Profile")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            onProfileButtonPressed()
                        } label: {
                            Image(systemName: "gear")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                }
        }
        .sheet(isPresented: $presentProfileView) {
            SettingsView()
        }
    }
    
    
    private func onProfileButtonPressed() {
        presentProfileView = true
    }
}

#Preview {
    ProfileView()
}
