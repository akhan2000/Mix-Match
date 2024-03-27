//
//  Profile.swift
//  MixMatch
//
//  Created by Christian Garvin on 3/27/23.
//

import SwiftUI

struct UserProfile: View {
    @State var user: User?
    @EnvironmentObject var dataStore: DataStore
    @State var isPresentingSongLibrary: Bool = false //Lucas
    @State var newPlaylistFormData = Playlist.FormData() //Lucas
    @State var selfPlaylistName: String = ""
    
    
    
    var body: some View {
        NavigationStack{

            if user == nil {
                noCurrentUser(user: $user)
            } else if (user?.username.lowercased() == dataStore.getCurrentUser()?.username.lowercased()) {
                VStack {
                    Text(dataStore.getCurrentUser()?.name ?? "").font(.title)
                    Text(dataStore.getCurrentUser()?.username ?? "").padding(.bottom)
                    Text("My Playlists").font(.title3)
                    
                    List {
                        Section(header: Text("Personal Playlists").font(.title2).frame(maxWidth: .infinity)) {
                            ForEach(dataStore.getCurrentUser()?.playlists.filter { $0.mixedMatchedBy.isEmpty } ?? []) { playlist in
                                PlaylistRow(playlist: playlist)
                            }
                        }
                        Section(header: Text("MixMatched Playlists").font(.title2).frame(maxWidth: .infinity)) {
                            ForEach(dataStore.getCurrentUser()?.playlists.filter { !$0.mixedMatchedBy.isEmpty } ?? []) { playlist in
                                PlaylistRow(playlist: playlist)
                            }
                        }
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                dataStore.signOutUser()
                                user = dataStore.getCurrentUser()
                            }) {
                                Text("Sign Out")
                            }
                        }
                    }
                }
            
                Button("Create new Playlist!") { isPresentingSongLibrary.toggle()}.padding(.bottom, 20)
                    .sheet(isPresented: $isPresentingSongLibrary) {
                      NavigationStack {
                          PlaylistForm(data: $newPlaylistFormData, toggle: $isPresentingSongLibrary)
                      } //end of navStack
                      .padding()
                    }
                
            } //end of else if
            
            else{
                VStack{
                    Text(dataStore.getOtherUser(username: user!.username)!.name).font(.title)
                    Text(dataStore.getOtherUser(username: user!.username)!.username).padding(.bottom)
                    if dataStore.getCurrentUser() != nil{
                        HStack{
                            Image(systemName: dataStore.userIsFriend(user!) ? "person.fill" : "person")
                                .foregroundColor(dataStore.userIsFriend(user!) ? .blue : .gray)
                            if dataStore.userIsFriend(user!){
                                Button("Remove Friend"){
                                    dataStore.removeUserFromFriendsList(user!)
                                }.foregroundColor(.red).padding(10)
                                  }else {
                                      Button("Add Friend") {
                                          dataStore.addUserToFriendsList(user!)
                                      }.padding(10)
                                }
                        }
                    } else{
                        Text("Sign in to add friends").padding(10)
                    }
                    List {
                        Section(header: Text("Personal Playlists").font(.title2).frame(maxWidth: .infinity)){
                            ForEach(dataStore.getOtherUser(username: user!.username)!.playlists.filter{$0.mixedMatchedBy.isEmpty}){ playlist in
                                PlaylistRow(playlist: playlist)
                            }
                        }
                        Section(header: Text("MixMatched Playlists").font(.title2).frame(maxWidth: .infinity)){
                            ForEach(dataStore.getOtherUser(username: user!.username)!.playlists.filter{!$0.mixedMatchedBy.isEmpty}){ playlist in
                                PlaylistRow(playlist: playlist)
                            }
                        }
                    }



                } //end of Vstack
            }

        }
    }
}

struct PlaylistRow: View{
    @State var playlist: Playlist
    var body: some View {
            NavigationLink(destination: PlaylistDetail(playlist: playlist)){
                HStack{
                    AsyncImage(url: playlist.coverUrl, content: { image in
                                          image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width:100, height: 100)
                                            .cornerRadius(6)
                                        }, placeholder: {
                                          if playlist.coverUrl != nil {
                                            ProgressView()
                                          } else {
                                            Image(systemName: "music.note.list").resizable()
                                                  .aspectRatio(contentMode: .fit)
                                                  .frame(width:75, height: 75)
                                                  .cornerRadius(6)
                                          }
                                        }).padding(.trailing, 40)
                    Text(playlist.name).bold()
            }
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile(user: User.previewData.first)
            .environmentObject(DataStore())
    }
}



