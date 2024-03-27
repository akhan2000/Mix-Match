import SwiftUI

struct SongDetail: View {
    @State var song: Song

    var body: some View {
          ScrollView {
              AsyncImage(url: song.coverUrl, content: { image in
                                    image
                                      .resizable()
                                      .aspectRatio(contentMode: .fit)
                                      .frame(width:300, height: 300)
                                      .cornerRadius(6)
                                  }, placeholder: {
                                      if song.coverUrl != nil {
                                      ProgressView()
                                    } else {
                                      Image(systemName: "music.note").resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width:150, height: 150)
                                            .cornerRadius(6)
                                    }
                                  }).padding(20)
              

              Text(song.name.uppercased()).font(.title).padding(10)
              Text(song.artist ?? "Unknown Artist").font(.title2).padding(10)
              
              //Metrics
              HStack{
                  Text("Genre: ").font(.title2).padding(.leading, 25).frame(maxWidth: .infinity, alignment: .leading)
                  Text(song.genre ?? "Unknown Artist").font(.title2).padding(10)
              }
              HStack{
                  Text("Key: ").font(.title2).padding(.leading, 25).frame(maxWidth: .infinity, alignment: .leading)
                  Text(song.key).font(.title2).padding(10)
              }
              HStack{
                  Text("Beats per minute (bpm): ").font(.title2).padding(.leading, 25).frame(maxWidth: .infinity, alignment: .leading)
                  Text("\(song.bpm ?? 0)").font(.title2).padding(10)
              }
              HStack{
                  Text("Popularity Rating (1-15): ").font(.title2).padding(.leading, 25).frame(maxWidth: .infinity, alignment: .leading)
                  Text("\(song.popularity ?? 0)").font(.title2).padding(10)
              }
              HStack{
                  Text("Song ID: ").font(.title2).padding(.leading, 25).frame(maxWidth: .infinity, alignment: .leading)
                  Text("\(song.popularity ?? 0)").font(.title2).padding(10)
              }
              
          }
    }
}

struct SongDetail_Previews: PreviewProvider {
  static var previews: some View {
      SongDetail(song: User.previewData[0].playlists[0].songs[0])
          .environmentObject(DataStore())
  }
}

