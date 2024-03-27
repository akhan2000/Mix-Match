//  ContentView.swift
//  MixMatch
//
//  Created by Christian Garvin on 3/27/23.
//

import SwiftUI

struct PlaylistData{            //struct for playlist creation
    var name: String = ""
    var friend: String = ""
    var vibe: String = ""
}

struct MainTabView: View {
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        TabView() {
            NavigationView {
                UserProfile(user: dataStore.getCurrentUser())
                
            }
            .tabItem {
                Label("Me", systemImage: "person")
            }
            NavigationView {
                FriendsList()
            }
            .tabItem {
                Label("Friends", systemImage: "person.3")
            }
            NavigationView {
                MixMatchView(user: dataStore.getCurrentUser())
            }
            .tabItem {
                Label("MixMatch", systemImage: "shuffle")
            }
            NavigationView {
                TestingViews()
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            NavigationView {
                FindFriends()
            }
            .tabItem {
                Label("Find Friends", systemImage: "figure.wave")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(DataStore())
    }
}
