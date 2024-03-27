//
//  PlayList.swift
//  Final Project
//
//  Created by Christian Garvin on 3/27/23.
//

import SwiftUI

struct MixMatchView: View {
    @State var user: User?
    @EnvironmentObject var dataStore: DataStore
    @State var playlistName: String = ""
    @State var playlistMood: MoodCategory = .party
    @State var isSuccessfull: Bool = false
    
    var body: some View {
       // NavigationStack{
        if dataStore.getCurrentUser()?.username.isEmpty ?? true {
            Text("Sign in to mix with friends").font(.title)
        }else{
            VStack{
                Text("MixMatch Playlist Details").font(.title).multilineTextAlignment(.center)
                Spacer()
                
                TextField("Enter name of playlist", text: $playlistName).padding().multilineTextAlignment(.center)
                HStack{
                    Text("Pick a mood:").padding()
                    Picker(selection: $playlistMood, label: Text("Mood")) {
                        ForEach(MoodCategory.allCases) { mood in
                            Text(mood.rawValue)
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Rectangle()
                    .fill(Color.black)
                    .frame(height: 10)
                    VStack{
                        Text("Choose Friends to Mix With").font(.title).multilineTextAlignment(.center)
                        NavigationView{
                            List(dataStore.getCurrentUser()!.friends) { friend in
                                            MixMatchFriendRow(user: friend)
                                    }
                        }
                    }
                Button("MixMatch!") {
                    dataStore.mixMatch(playlistName, playlistMood, dataStore.getCurrentUser()!) //Lucas edit for Garv
                    isSuccessfull.toggle()
                    playlistName = ""
                    playlistMood = .party
                }.disabled(playlistName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || dataStore.mixMatchFriends.isEmpty).padding(.bottom, 10)
            } //end of vstack
            .alert(isPresented: $isSuccessfull) {
                Alert(title: Text("MixMatched a Playlist!"),
                    message: Text("Generated and shared a combined playlist"),
                    dismissButton: .default(Text("OK")))
                }
        } //end of else statement
    }
}

struct MixMatchFriendRow: View {
    @State var user: User
    @EnvironmentObject var dataStore: DataStore
    var body: some View {
        Button(action: {
            if !dataStore.userIsInMixMatch(user){
                dataStore.addUserToMixMatch(user)
            } else{
                dataStore.removeUserFromMixMatch(user)
            }
        }) {
            HStack{
                VStack(alignment: .leading){
                    Text(user.username)
                    Text(user.name).bold()
                }
                Spacer()
                if (dataStore.userIsInMixMatch(user)){
                    Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                }
                else{
                    Image(systemName: "circle")
                }
            }
        }
    }
}
