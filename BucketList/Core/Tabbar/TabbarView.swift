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
            
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
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
            
            TrackView()
                .tabItem {
                    Image(systemName: "arrow.triangle.2.circlepath")
                    Text("Track")
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
