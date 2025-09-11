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
            List {
                categoriesSection
                goalsSection
            }
            .frame(maxWidth: .infinity, alignment: .leading)
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
        .removeListRowFormatting()
    }
    
    private var goalsSection: some View {
        Section {
            VStack(alignment: .leading) {
                Text("Your goals")
                    .font(.title)
                    .fontWeight(.bold)
                ScrollView(.horizontal) {
                    HStack {
                        
                    }
                }
            }
        }
        .removeListRowFormatting()
    }
}

#Preview {
    ExploreView()
}
