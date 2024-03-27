//
//  SongLibrary.swift
//  MixMatch
//
//  Created by Lucas Gibb on 4/25/23.
//
//NOT BEING USED RIGHT NOW
//import Foundation
//import SwiftUI
//
//struct SongLibrary: View {
//    @State var song: Song
//
//    var body: some View {
//          ScrollView {
//              AsyncImage(url: song.coverUrl, content: { image in
//                                    image
//                                      .resizable()
//                                      .aspectRatio(contentMode: .fit)
//                                      .frame(width:300, height: 300)
//                                      .cornerRadius(6)
//                                  }, placeholder: {
//                                      if song.coverUrl != nil {
//                                      ProgressView()
//                                    } else {
//                                      Image(systemName: "music.note").resizable()
//                                            .aspectRatio(contentMode: .fit)
//                                            .frame(width:150, height: 150)
//                                            .cornerRadius(6)
//                                    }
//                                  }).padding(20)
//
//
//              Text(song.name.uppercased()).font(.title).padding(10)
//              Text(song.artist ?? "Unknown Artist").font(.title2).padding(10)
//              Text("Other important stuff we think we should add (other song attributes?)")
//          }
//    }
//}

