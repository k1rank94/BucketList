//
//  CreateAccountView.swift
//  BucketList
//
//  Created by Kiran on 17/09/25.
//

import SwiftUI
import AuthenticationServices

struct CreateAccountView: View {
    
    @Environment(\.authService) private var authService
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Create account")
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text("Don't lose your data—Sign In to Save Your Work!")
                .font(.title2)
                .fontWeight(.medium)
            Button {
                onSignInWithApplePressed()
            } label: {
                SignInWithAppleButtonView(
                    type: .signIn,
                    style: .black,
                    cornerRadius: 30
                )
                .frame(height: 50)
                .padding(.top)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
    
    private func onSignInWithApplePressed()  {
        Task {
            do {
                let authInfo = try await authService.signInWithApple()
            } catch {
                print("Failed to sign in with error \(error)")
            }
        }
        dismiss()
    }
}

#Preview {
    CreateAccountView()
}
