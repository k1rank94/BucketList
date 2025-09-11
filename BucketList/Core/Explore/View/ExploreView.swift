//
//  ExploreView.swift
//  BucketList
//
//  Created by Kiran on 11/07/25.
//

import SwiftUI

struct ExploreView: View {
    @State var exploreViewModel = ExploreViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) {
                categoriesSection
                goalsSection
            }
            .padding()
            .navigationTitle("Home")
            .navigationBarHidden(true)
        }
    }
    
    private var headerText: some View {
        Text("What do\n")
            .font(.title)
            .fontWeight(.medium)
        +
        Text("you want to do?")
            .font(.title)
            .fontWeight(.bold)
    }
    
    private var categoriesSection: some View {
        Section {
            VStack(alignment: .leading) {
                headerText
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(exploreViewModel.categories) { category in
                            VStack {
                                Image(systemName: category.imageString)
                                    .frame(width: 100, height: 100)
                                    .aspectRatio(1, contentMode: .fit)
                                    .background(Color.orange.gradient)
                                    .clipShape(Circle())
                                Text(category.name)
                                    .font(.caption)
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var goalsSection: some View {
        VStack() {
            Text("Your goals")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
            ZStack(alignment: .center) {
                if exploreViewModel.userBucketListItems.isEmpty {
                    VStack(spacing: 0) {
                        Image(.imgOnboardingBoyWithGuitar)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 300, height: 300, alignment: .center)
                        Text("You have no goals yet")
                            .font(.callout)
                            .fontWeight(.semibold)
                            .offset(y: -16)
                    }
                    .offset(y: -30)
                } else {
                    ScrollView(.horizontal) {
                        HStack {
                            
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ExploreView()
}
