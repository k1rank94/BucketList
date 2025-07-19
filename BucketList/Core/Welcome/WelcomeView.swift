//
//  WelcomeView.swift
//  BucketList
//
//  Created by Kiran on 08/07/25.
//

import SwiftUI

struct WelcomeView: View {
    // MARK: - STATE
    // State properties to control the animation for each element
    @State private var animateImage = false
    @State private var animateWelcomeText = false
    @State private var animateSecondLine = false

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // Animate the image view
                imageView
                    .scaleEffect(animateImage ? 1.0 : 0.8)
                    .opacity(animateImage ? 1.0 : 0.0)
                
                Spacer()
                
                // Animate the text views
                welcomeText
                
                getStartedButton
                    
            }
            .padding(20)
            .padding(.bottom, 10)
            .onAppear(perform: setupAnimation) // Trigger animations when the view appears
        }
    }
    
    // MARK: - UI COMPONENTS
    private var imageView: some View {
        Image(.imgWelcomeBoyWithMap)
            .resizable()
            .aspectRatio(1, contentMode: .fill)
            .frame(width: 200, height: 400)
            .padding(.bottom, 10)
    }
    
    private var welcomeText: some View {
        VStack(alignment: .leading, spacing: 5) {
            // First line of text
            Text("Welcome!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .opacity(animateWelcomeText ? 1.0 : 0.0)
                .offset(y: animateWelcomeText ? 0 : -30)
            
            // Second line of text
            (
                Text("Let's make ")
                    .font(.title)
                    .fontWeight(.medium)
                +
                Text("memories")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(hex: "#F5A623"))
                +
                Text(" that last ")
                    .font(.title)
                    .fontWeight(.medium)
                +
                Text("forever")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color(hex: "#F5A623"))
            )
            .opacity(animateSecondLine ? 1.0 : 0.0)
            .offset(y: animateSecondLine ? 0 : 30) // Slides up from below
        }
        .lineSpacing(5)
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
    
    private var getStartedButton: some View {
        NavigationLink {
            OnboardingIntroView()
        } label: {
            Text("Get Started")
                .commonButtonStyle()
        }

    }
    
    // MARK: - ANIMATION LOGIC
    private func setupAnimation() {
        // Using explicit animations with delays to create a staggered, cascading effect
        
        // 1. Animate Image
        withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.7)) {
            animateImage = true
        }
        
        // 2. Animate "Welcome!"
        withAnimation(.easeInOut(duration: 0.7).delay(0.8)) {
            animateWelcomeText = true
        }
        
        // 3. Animate the second line of text
        withAnimation(.easeInOut(duration: 0.7).delay(1.2)) {
            animateSecondLine = true
        }

    }
}

#Preview {
    WelcomeView()
}
