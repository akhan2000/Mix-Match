//
//  PlaylistDetail.swift
//  MixMatch
//
//  Created by Christian Garvin on 3/27/23.
//

import SwiftUI

struct PlaylistDetail: View {
    @State var playlist: Playlist
    
    var body: some View {
        if !playlist.mixedMatchedBy.isEmpty{
            HStack{
                Text("MixMatched By:").padding(5)
                Text(playlist.mixedMatchedBy)
            }
        }
        NavigationStack{
            List(playlist.songs){ song in
                NavigationLink(destination: SongDetail(song: song)){
                    SongRow(song: song)
            }
        }
        }
    }
}

struct SongRow: View{
    @State var song: Song
    var body: some View {
                HStack{
                    AsyncImage(url: song.coverUrl, content: { image in
                                          image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width:100, height: 100)
                                            .cornerRadius(6)
                                        }, placeholder: {
                                          if song.coverUrl != nil {
                                            ProgressView()
                                          } else {
                                            Image(systemName: "music.note").resizable()
                                                  .aspectRatio(contentMode: .fit)
                                                  .frame(width:75, height: 75)
                                                  .cornerRadius(6)
                                          }
                                        }).padding(.trailing, 40)
                    VStack(alignment: .leading){
                        Text(song.name).bold()
                        Text(song.artist ?? "Unknown Artist")
                    }
            }
    }
}

struct PlaylistDetail_Previews: PreviewProvider {
  static var previews: some View {
      PlaylistDetail(playlist: User.previewData[0].playlists[0])
          .environmentObject(DataStore())
  }
}
