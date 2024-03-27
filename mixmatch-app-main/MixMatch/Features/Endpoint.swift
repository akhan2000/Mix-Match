////
////  Endpoint.swift
////  MixMatch
////
////  Created by Asfandyar Khan on 4/25/23.
////
//
//import SwiftUI
//import Foundation
//
//struct Endpoint: View {
//    @State private var searchText = ""
//    @State private var songs: [Song]?
//    private let api = LastFMAPI()
//    
//    var body: some View {
//        VStack {
//            SearchBar(text: $searchText, onCommit: {
//                api.searchSongs(songName: searchText) { songs in
//                    DispatchQueue.main.async {
//                        self.songs = songs
//                    }
//                }
//            })
//            if let songs = songs {
//                List(songs) { song in
//                    Text(song.name)
//                }
//            } else {
//                ProgressView()
//                Spacer()
//            }
//        }
//    }
//}
//struct SearchBar: View {
//    @Binding var text: String
//    var onCommit: () -> Void
//    
//    var body: some View {
//        HStack {
//            TextField("Search", text: $text, onCommit: onCommit)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//            Button(action: onCommit) {
//                Text("Search")
//            }
//        }
//        .padding()
//    }
//}
//
//
//struct Endpoint_Previews: PreviewProvider {
//    static var previews: some View {
//        Endpoint()
//            .environmentObject(DataStore())
//    }
//}
