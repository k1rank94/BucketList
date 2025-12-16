//
//  OnboardingIntroView.swift
//  BucketList
//
//  Created by Kiran on 11/07/25.
//

import SwiftUI

struct OnboardingCompletedView: View {
    @Environment(UserManager.self) private var userManager
    @Environment(AppState.self) var appState
    var body: some View {
        VStack() {
            imageView
            introHeadline
            introSubheadline
            Spacer()
            continueButton
        }
        .padding()
        .padding(.bottom, 20)
    }
    
    private var imageView: some View {
        Image(.imgOnboardingBoyWithStick)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 200, height: 300)
            .padding(.top, 50)
    }
    
    private var introHeadline: some View {
        (
            Text("Your ")
                .font(.title)
                .fontWeight(.bold)
            +
            Text("Adventure")
                .font(.title)
                .fontWeight(.bold)
    //            .foregroundStyle(Color(hex: "#F5A623"))
            + Text(" awaits!")
                .font(.title)
                .fontWeight(.bold)

        )
    }
    
    private var introSubheadline: some View {
        Text("Start by capturing every goal and destination. This is the first step to making them a reality ✨")
            .font(.title2)
            .fontWeight(.medium)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
    
    private var continueButton: some View {
        Button {
            onGetStartedButtonTapped()
        } label: {
            Text("Get Started")
                .commonButtonStyle()
        }

    }
    
    private func onGetStartedButtonTapped() {
        do {
            try userManager.markOnboardingCompleted(as: true, for: userManager.getCurrentUserId())
        } catch {
            print("Failed to update mark markOnboardingCompleted with \(error)")
        }
        appState.updateLoginStatus(true)
    }
}

#Preview {
    OnboardingCompletedView()
        .environment(AppState())
}
