//
//  TabbarView.swift
//  BucketList
//
//  Created by Kiran on 08/07/25.
//

import SwiftUI

struct TabbarView: View {
    
    var body: some View {
        TabView {
            
            ExploreView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }
            
            AddGoalView()
                .tabItem {
                    Image(systemName: "plus")
                    Text("Add Goal")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    TabbarView()
}
