//
//  FriendsList.swift
//  Final Project
//
//  Created by Christian Garvin on 3/27/23.
//

import SwiftUI

struct FriendsList: View {
    @EnvironmentObject var dataStore: DataStore
    
    var body: some View {
        if dataStore.getCurrentUser() == nil{
            Text("Sign in to See Your Friends").font(.title)
        } else if dataStore.getCurrentUser()!.friends.isEmpty{
            HStack{
                Text("Make Some Friends").font(.title)
                Image(systemName: "smiley").font(.largeTitle)
            }
        }
        else{
            NavigationStack {
                VStack{
                    Text("My Friends").font(.title)
                    List(dataStore.getCurrentUser()!.friends) { friend in
                        NavigationLink(destination: UserProfile(user: friend)) {
                            UserRow(user: friend)
                        }
                    }
                }
            }
        }
    }
}

struct FriendsList_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      FriendsList()
            .environmentObject(DataStore())
    }
  }
}
