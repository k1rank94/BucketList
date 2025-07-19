//
//  HomeView.swift
//  BucketList
//
//  Created by Kiran on 11/07/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                headerText
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
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
    
    private var categoriesList: some View {
        ScrollView(.horizontal) {
            
        }
    }
}

#Preview {
    HomeView()
}
