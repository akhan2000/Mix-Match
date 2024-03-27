import SwiftUI


struct PlaylistFormSongRow: View {
    @State var song: Song
    @EnvironmentObject var dataStore: DataStore
    var body: some View {
        Button(action: {
            if !dataStore.songIsInSelfPlaylist(song){
                dataStore.addSongToSelfPlaylist(song)
            } else{
                dataStore.removeSongSelfPlaylist(song)
            }
        }) {
            HStack{
                VStack(alignment: .leading){
                    Text(song.name)
                    Text(song.artist ?? "").bold()
                }
                Spacer()
                if (dataStore.songIsInSelfPlaylist(song)){
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




struct PlaylistForm: View {
    @Binding var data: Playlist.FormData
    //@Binding var isSongSelected : Bool
    @EnvironmentObject var dataStore: DataStore
    @State var songs = Song.songLibrary
    @State var playlistName : String = ""
    @Binding var toggle : Bool
    

    var body: some View {
            Button("Create") {
                var newPlaylist = Playlist(name: playlistName, songs: dataStore.selectedSongs)
                dataStore.addPlaylistToUser(dataStore.getCurrentUser()!, newPlaylist)
                toggle.toggle()

            }.disabled(playlistName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || dataStore.selectedSongs.isEmpty).padding(.bottom, 10)
        VStack{
            Form {
                TextFieldWithLabel(label: "Playlist Name", text: $playlistName, prompt: "Enter a Name")
                //Text("Song Library").font(.title2).frame(maxWidth: .infinity)
                Text("Song Library").font(.title2).frame(maxWidth: .infinity)
                List(songs) { song in
                    PlaylistFormSongRow(song: song)
            }


            } //Form
            
        } //some View
        
    }//end of Vstack
} //PlaylisteForm view bracket


struct TextFieldWithLabel: View {
    let label: String
    @Binding var text: String
    var prompt: String? = nil

  var body: some View {
    VStack(alignment: .leading) {
      Text(label)
        .bold()
        .font(.caption)
      TextField(label, text: $text, prompt: prompt != nil ? Text(prompt!) : nil)
        .padding(.bottom, 20)
    }
  }
}

struct SongRowForm: View{
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

let songLibrary: [Song] = [
        Song(id: "1", name:"Something in the Orange", artist: "Zach Bryan", genre: "Country", bpm:120, popularity: 12, key:"major"),
        Song(id: "2",name:"Feathered Indians", artist: "Tyler Childers", genre: "Country", bpm:120, popularity: 12, key:"major"),
        Song(id: "25", name:"Tequila Does", artist: "Miranda Lambert", genre: "Country", bpm:130, popularity: 10, key:"major"),
        Song(id: "26", name:"Whiskey Glasses", artist: "Morgan Wallen", genre: "Country", bpm:80, popularity: 8, key:"major"),
        Song(id: "3", name:"Tunnel Vision", artist:"Kodak Black", bpm:120, popularity: 12, key:"major"),
        Song(id: "4", name:"Look at Me!", artist:"XXXTENTACION", bpm:120, popularity: 12, key:"major"),
        Song(id: "27", name:"Topanga", artist:"Trippie Redd", bpm:140, popularity: 9, key:"major"),
        Song(id: "28", name:"I'm Upset", artist:"Drake", bpm:95, popularity: 7, key:"major"),
        Song(id: "5", name: "Stolen Dance", artist: "Milky Chance", bpm:120, popularity: 12, key:"major"),
        Song(id: "29", name: "Sweater Weather", artist: "The Neighbourhood", bpm:85, popularity: 11, key:"major"),
        Song(id: "6", name:"Levels", artist: "Avicii", genre: "EDM", bpm:120, popularity: 11, key:"major"),
        Song(id: "10", name:"Five More Hours", artist: "Mabel", genre: "EDM", bpm:130, popularity: 10, key:"major"),
        Song(id: "11", name:"Burn This House", artist: "J. Worra", genre: "EDM", bpm:120, popularity: 12, key:"major"),
        Song(id: "12", name:"Freeze", artist: "Kygo", genre: "EDM", bpm:140, popularity: 13, key:"major"),
        Song(id: "13", name:"One Kiss", artist: "Calvin Harris", genre: "EDM", bpm:110, popularity: 7, key:"major"),
        Song(id: "14", name:"More Than Friends", artist: "James Hype", genre: "EDM", bpm:100, popularity: 12, key:"major"),
        Song(id: "15", name:"Sweet Nothing", artist: "Calvin Harris", genre: "EDM", bpm:100, popularity: 8, key:"major"),
        Song(id: "17", name:"Good Days", artist: "SZA", genre: "EDM", bpm:120, popularity: 10, key:"major"),
        Song(id: "31", name: "Uptown Funk", artist: "Mark Ronson ft. Bruno Mars", genre: "Funk", bpm: 115, popularity: 9, key: "D# minor"),
        Song(id: "32", name: "Despacito", artist: "Luis Fonsi ft. Daddy Yankee", genre: "Latin Pop", bpm: 89, popularity: 10, key: "B minor"),
        Song(id: "33", name: "I Will Always Love You", artist: "Whitney Houston", genre: "R&B", bpm: 66, popularity: 9, key: "A major"),
        Song(id: "34", name: "Billie Jean", artist: "Michael Jackson", genre: "Pop", bpm: 117, popularity: 9, key: "F# minor"),
        Song(id: "35", name: "Bohemian Rhapsody", artist: "Queen", genre: "Rock", bpm: 72, popularity: 10, key: "B♭ major"),
        Song(id: "36", name: "Don't Stop Believin'", artist: "Journey", genre: "Rock", bpm: 120, popularity: 8, key: "E major"),
        Song(id: "37", name: "Hotel California", artist: "Eagles", genre: "Rock", bpm: 75, popularity: 9, key: "B minor"),
        Song(id: "38", name: "Sweet Child O' Mine", artist: "Guns N' Roses", genre: "Rock", bpm: 128, popularity: 9, key: "D major"),
        Song(id: "39", name: "All of Me", artist: "John Legend", genre: "R&B", bpm: 63, popularity: 9, key: "A♭ major"),
        Song(id: "40", name: "Thriller", artist: "Michael Jackson", genre: "Pop", bpm: 118, popularity: 9, key: "C minor"),
        Song(id: "41", name: "Stairway to Heaven", artist: "Led Zeppelin", genre: "Rock", bpm: 63, popularity: 9, key: "A minor"),
        Song(id: "42", name: "Smells Like Teen Spirit", artist: "Nirvana", genre: "Grunge", bpm: 116, popularity: 8, key: "F minor"),
        Song(id: "43", name: "Hello", artist: "Adele", genre: "Pop", bpm: 79, popularity: 8, key: "F minor"),
        Song(id: "44", name: "Wonderwall", artist: "Oasis", genre: "Rock", bpm: 87, popularity: 8, key: "F# minor"),
        Song(id: "45", name: "No Woman No Cry", artist: "Bob Marley & The Wailers", genre: "Reggae", bpm: 103, popularity: 8, key: "C major"),
        Song(id: "7", name:"Moutain Man", artist:"Some cowboy out west", bpm:120, popularity: 14, key:"major"),
        Song(id: "18", name:"Wagon Wheel", artist:"Darius Rucker", bpm:100, popularity: 15, key:"major"),
        Song(id: "19", name:"Springsteen", artist:"Eric Church", bpm:90, popularity: 10, key:"major"),
        Song(id: "20", name:"Honey Bee", artist:"Blake Shelton", bpm:110, popularity: 9, key:"major"),
        Song(id: "21", name:"Tenessee Whiskey", artist:"Chris Stapleton", bpm:80, popularity: 5, key:"major"),
        Song(id: "22", name:"Rumor", artist:"Lee Brice", bpm:100, popularity: 11, key:"major"),
        Song(id: "23", name:"Georgia Time", artist:"Riley Green", bpm:120, popularity: 10, key:"major"),
        Song(id: "24", name:"Dirt on My Boots", artist:"Jon Pardi", bpm:70, popularity: 12, key:"major"),
        Song(id: "8", name:"Democrats Rock (remix)", artist: "Bernie Sanders", genre: "EDM", bpm:120, popularity: 12, key:"major"),
        Song(id: "47", name: "Take On Me", artist: "A-ha", genre: "New Wave", bpm: 168, popularity: 8, key: "C# minor"),
        Song(id: "48", name: "Sweet Child O' Mine", artist: "Guns N' Roses", genre: "Rock", bpm: 126, popularity: 9, key: "D major"),
        Song(id: "49", name: "Livin' On A Prayer", artist: "Bon Jovi", genre: "Rock", bpm: 123, popularity: 9, key: "Bb major"),
        Song(id: "50", name: "With Or Without You", artist: "U2", genre: "Rock", bpm: 110, popularity: 9, key: "D major"),
        Song(id: "51", name: "Every Breath You Take", artist: "The Police", genre: "Pop", bpm: 117, popularity: 8, key: "A minor"),
        Song(id: "52", name: "Jump", artist: "Van Halen", genre: "Rock", bpm: 132, popularity: 8, key: "C major"),
        Song(id: "53", name: "Purple Rain", artist: "Prince", genre: "Pop", bpm: 94, popularity: 8, key: "Bb major"),
        Song(id: "54", name: "I Wanna Dance With Somebody", artist: "Whitney Houston", genre: "Pop", bpm: 120, popularity: 8, key: "F# minor"),
        Song(id: "55", name: "Don't Stop Believin'", artist: "Journey", genre: "Rock", bpm: 120, popularity: 9, key: "E major"),
        Song(id: "56", name: "Wake Me Up Before You Go-Go", artist: "Wham!", genre: "Pop", bpm: 163, popularity: 8, key: "G major"),
        Song(id: "57", name: "The Way You Make Me Feel", artist: "Michael Jackson", genre: "Pop", bpm: 114, popularity: 8, key: "E major"),
        Song(id: "58", name: "Eye of the Tiger", artist: "Survivor", genre: "Rock", bpm: 109, popularity: 8, key: "B minor"),
        Song(id: "59", name: "Karma Chameleon", artist: "Culture Club", genre: "Pop", bpm: 104, popularity: 8, key: "C major"),
        Song(id: "60", name: "Love Shack", artist: "The B-52's", genre: "Pop", bpm: 133, popularity: 8, key: "A major"),
        Song(id: "61", name: "How Will I Know", artist: "Whitney Houston", genre: "Pop", bpm: 120, popularity: 7, key: "G# minor"),
        Song(id: "9", name:"Republicans Rule (remix)", artist:"Donald Trump", bpm:120, popularity: 12, key:"major"),
        Song(id: "62", name: "Rolling in the Deep", artist: "Adele", genre: "Pop", bpm: 104, popularity: 9, key: "C minor"),
        Song(id: "63", name: "Call Me Maybe", artist: "Carly Rae Jepsen", genre: "Pop", bpm: 120, popularity: 8, key: "G major"),
        Song(id: "64", name: "Countdown", artist: "Beyoncé", genre: "R&B", bpm: 83, popularity: 6, key: "B minor"),
        Song(id: "65", name: "I Will Always Love You", artist: "Whitney Houston", genre: "Pop", bpm: 135, popularity: 8, key: "Bb major"),
        Song(id: "66", name: "Can't Hold Us", artist: "Macklemore & Ryan Lewis ft. Ray Dalton", genre: "Hip-hop", bpm: 146, popularity: 7, key: "D minor"),
        Song(id: "67", name: "We Found Love", artist: "Rihanna ft. Calvin Harris", genre: "Pop", bpm: 128, popularity: 8, key: "F# minor"),
        Song(id: "68", name: "Get Lucky", artist: "Daft Punk ft. Pharrell Williams & Nile Rodgers", genre: "Disco", bpm: 116, popularity: 9, key: "F# minor"),
        Song(id: "69", name: "Thinking Out Loud", artist: "Ed Sheeran", genre: "Pop", bpm: 79, popularity: 8, key: "D major"),
        Song(id: "70", name: "Shape of You", artist: "Ed Sheeran", genre: "Pop", bpm: 96, popularity: 9, key: "C# minor"),
        Song(id: "71", name: "Uptown Funk", artist: "Mark Ronson ft. Bruno Mars", genre: "Funk", bpm: 115, popularity: 9, key: "D# minor"),
        Song(id: "72", name: "Royals", artist: "Lorde", genre: "Pop", bpm: 85, popularity: 7, key: "D major"),
        Song(id: "73", name: "Shallow", artist: "Lady Gaga & Bradley Cooper", genre: "Pop", bpm: 96, popularity: 9, key: "G major"),
        Song(id: "74", name: "Blinding Lights", artist: "The Weeknd", genre: "Pop", bpm: 171, popularity: 10, key: "F minor"),
        Song(id: "75", name: "Stay", artist: "Rihanna ft. Mikky Ekko", genre: "Pop", bpm: 111, popularity: 8, key: "C major"),
        Song(id: "76", name: "All of Me", artist: "John Legend", genre: "Pop", bpm: 63, popularity: 8, key: "A# major"),
        Song(id: "77", name: "Happy", artist: "Pharrell Williams", genre: "Pop", bpm: 160, popularity: 8, key: "E minor"),
        Song(id: "78", name: "Sorry", artist: "Justin Bieber", genre: "Pop", bpm: 100, popularity: 7, key: "C# minor"),
        Song(id: "79", name: "Stayin' Alive", artist: "Bee Gees", genre: "Disco", bpm: 103, popularity: 9, key: "F# minor"),
        Song(id: "80", name: "Bohemian Rhapsody", artist: "Queen", genre: "Rock", bpm: 72, popularity: 10, key: "Bb major"),
        Song(id: "81", name: "I Will Survive", artist: "Gloria Gaynor", genre: "Disco", bpm: 120, popularity: 8, key: "A minor"),
        Song(id: "82", name: "Hotel California", artist: "Eagles", genre: "Rock", bpm: 75, popularity: 9, key: "B minor"),
        Song(id: "83", name: "Superstition", artist: "Stevie Wonder", genre: "Funk", bpm: 105, popularity: 8, key: "E minor"),
        Song(id: "84", name: "Don't Stop 'Til You Get Enough", artist: "Michael Jackson", genre: "Disco", bpm: 123, popularity: 8, key: "Bb minor"),
        Song(id: "85", name: "Imagine", artist: "John Lennon", genre: "Rock", bpm: 75, popularity: 9, key: "C major"),
        Song(id: "86", name: "Good Times", artist: "Chic", genre: "Disco", bpm: 110, popularity: 7, key: "A minor"),
        Song(id: "87", name: "Stay With Me", artist: "The Faces", genre: "Rock", bpm: 121, popularity: 6, key: "D major"),
        Song(id: "88", name: "Dancing Queen", artist: "ABBA", genre: "Disco", bpm: 100, popularity: 9, key: "A minor"),
        Song(id: "89", name: "Let's Stay Together", artist: "Al Green", genre: "Soul", bpm: 103, popularity: 7, key: "F major"),
        Song(id: "90", name: "American Pie", artist: "Don McLean", genre: "Folk", bpm: 116, popularity: 8, key: "C major"),
        Song(id: "91", name: "Sweet Home Alabama", artist: "Lynyrd Skynyrd", genre: "Rock", bpm: 96, popularity: 7, key: "G major"),
        Song(id: "92", name: "Killing Me Softly With His Song", artist: "Roberta Flack", genre: "Soul", bpm: 89, popularity: 7, key: "Eb major"),
        Song(id: "93", name: "Born To Run", artist: "Bruce Springsteen", genre: "Rock", bpm: 147, popularity: 8, key: "E major"),
        Song(id: "94", name: "Let's Get It On", artist: "Marvin Gaye", genre: "Soul", bpm: 81, popularity: 8, key: "Bb major"),
        Song(id: "95", name: "Free Bird", artist: "Lynyrd Skynyrd", genre: "Rock", bpm: 150, popularity: 7, key: "G major"),
        Song(id: "96", name: "At Night", artist: "Shakedown", genre: "House", bpm: 125, popularity: 8, key: "G minor"),
        Song(id: "97", name: "Music Sounds Better with You", artist: "Stardust", genre: "House", bpm: 122, popularity: 9, key: "E flat major"),
        Song(id: "98", name: "I Feel Love", artist: "Donna Summer", genre: "House", bpm: 130, popularity: 8, key: "E minor"),
        Song(id: "99", name: "French Kiss", artist: "Lil' Louis", genre: "House", bpm: 126, popularity: 7, key: "C minor"),
        Song(id: "100", name: "Work It", artist: "Missy Elliott", genre: "House", bpm: 129, popularity: 9, key: "F minor"),
        Song(id: "101", name: "Your Love", artist: "Frankie Knuckles", genre: "House", bpm: 125, popularity: 8, key: "A minor"),
        Song(id: "102", name: "Needin' U", artist: "David Morales", genre: "House", bpm: 128, popularity: 7, key: "G minor"),
        Song(id: "103", name: "Promised Land", artist: "Joe Smooth", genre: "House", bpm: 120, popularity: 7, key: "G minor"),
        Song(id: "104", name: "Strings of Life", artist: "Derrick May", genre: "House", bpm: 130, popularity: 7, key: "G minor"),
        Song(id: "105", name: "Finally", artist: "CeCe Peniston", genre: "House", bpm: 120, popularity: 8, key: "G minor"),
        Song(id: "106", name: "Big Fun", artist: "Inner City", genre: "House", bpm: 126, popularity: 7, key: "E minor"),
        Song(id: "107", name: "Satisfy", artist: "Catz 'n Dogz", genre: "House", bpm: 126, popularity: 7, key: "G minor"),
        Song(id: "108", name: "Lady (Hear Me Tonight)", artist: "Modjo", genre: "House", bpm: 124, popularity: 8, key: "D minor"),
        Song(id: "109", name: "Right Here, Right Now", artist: "Fatboy Slim", genre: "House", bpm: 127, popularity: 8, key: "C# minor"),
        Song(id: "110", name: "The Whistle Song", artist: "Frankie Knuckles", genre: "House", bpm: 123, popularity: 7, key: "G minor"),
        Song(id: "111", name: "Let Me Show You", artist: "CamelPhat", genre: "House", bpm: 123, popularity: 8, key: "G minor"),
        Song(id: "112", name: "Pjanoo", artist: "Eric Prydz", genre: "House", bpm: 126, popularity: 8, key: "D minor"),
        Song(id: "113", name: "Everybody's Free (To Feel Good)", artist: "Rozalla", genre: "House", bpm: 128, popularity: 7, key: "A minor"),
        Song(id: "114", name: "Paranoid", artist: "Black Sabbath", genre: "Rock", bpm: 163, popularity: 7, key: "E minor"),
        Song(id: "115", name: "More Than a Feeling", artist: "Boston", genre: "Rock", bpm: 132, popularity: 7, key: "D major"),
        Song(id: "116", name: "Born to Run", artist: "Bruce Springsteen", genre: "Rock", bpm: 146, popularity: 7, key: "E major"),
        Song(id: "117", name: "Sweet Emotion", artist: "Aerosmith", genre: "Rock", bpm: 98, popularity: 7, key: "D major"),
        Song(id: "118", name: "Tom Sawyer", artist: "Rush", genre: "Rock", bpm: 81, popularity: 7, key: "B minor"),
        Song(id: "119", name: "Stairway to Heaven", artist: "Led Zeppelin", genre: "Rock", bpm: 65, popularity: 7, key: "A minor"),
        Song(id: "120", name: "Layla", artist: "Derek and the Dominos", genre: "Rock", bpm: 98, popularity: 7, key: "D minor"),
        Song(id: "121", name: "All Along the Watchtower", artist: "Jimi Hendrix", genre: "Rock", bpm: 96, popularity: 7, key: "C major"),
        Song(id: "122", name: "Walk This Way", artist: "Aerosmith", genre: "Rock", bpm: 106, popularity: 7, key: "A minor"),
        Song(id: "123", name: "Crazy Train", artist: "Ozzy Osbourne", genre: "Rock", bpm: 137, popularity: 7, key: "A minor"),
        Song(id: "124", name: "Comfortably Numb", artist: "Pink Floyd", genre: "Rock", bpm: 56, popularity: 7, key: "Bb major"),
        Song(id: "125", name: "Highway to Hell", artist: "AC/DC", genre: "Rock", bpm: 115, popularity: 7, key: "A major"),
        Song(id: "126", name: "Kashmir", artist: "Led Zeppelin", genre: "Rock", bpm: 84, popularity: 7, key: "A minor"),
        Song(id: "127", name: "Livin' on a Prayer", artist: "Bon Jovi", genre: "Rock", bpm: 123, popularity: 7, key: "Bb major"),
        Song(id: "128", name: "Smells Like Teen Spirit", artist: "Nirvana", genre: "Rock", bpm: 116, popularity: 7, key: "F minor"),
        Song(id: "129", name: "Thunderstruck", artist: "AC/DC", genre: "Rock", bpm: 133, popularity: 7, key: "B major"),
        Song(id: "130", name: "Pour Some Sugar on Me", artist: "Def Leppard", genre: "Rock", bpm: 85, popularity: 7, key: "D major"),
        Song(id: "131", name: "Hey Ya!", artist: "OutKast", genre: "Pop", bpm: 160, popularity: 9, key: "D major"),
        Song(id: "132", name: "In Da Club", artist: "50 Cent", genre: "Hip Hop", bpm: 90, popularity: 8, key: "Bb minor"),
        Song(id: "133", name: "Crazy in Love", artist: "Beyoncé ft. Jay-Z", genre: "R&B", bpm: 99, popularity: 8, key: "C major"),
        Song(id: "134", name: "Vertigo", artist: "U2", genre: "Rock", bpm: 126, popularity: 7, key: "B minor"),
        Song(id: "135", name: "The Scientist", artist: "Coldplay", genre: "Rock", bpm: 74, popularity: 6, key: "F major"),
        Song(id: "136", name: "Lose Yourself", artist: "Eminem", genre: "Hip Hop", bpm: 86, popularity: 9, key: "D minor"),
        Song(id: "137", name: "Hips Don't Lie", artist: "Shakira ft. Wyclef Jean", genre: "Latin Pop", bpm: 100, popularity: 8, key: "Bb minor"),
        Song(id: "138", name: "Clocks", artist: "Coldplay", genre: "Rock", bpm: 132, popularity: 7, key: "D# minor"),
        Song(id: "139", name: "Boulevard of Broken Dreams", artist: "Green Day", genre: "Rock", bpm: 84, popularity: 8, key: "G minor"),
        Song(id: "140", name: "I Gotta Feeling", artist: "The Black Eyed Peas", genre: "Pop", bpm: 128, popularity: 7, key: "C major"),
        Song(id: "141", name: "Yeah!", artist: "Usher ft. Lil Jon, Ludacris", genre: "R&B", bpm: 105, popularity: 8, key: "G# minor"),
        Song(id: "142", name: "Bad Romance", artist: "Lady Gaga", genre: "Pop", bpm: 119, popularity: 8, key: "G minor"),
        Song(id: "143", name: "A Thousand Miles", artist: "Vanessa Carlton", genre: "Pop", bpm: 96, popularity: 6, key: "Bb major"),
        Song(id: "144", name: "Chasing Cars", artist: "Snow Patrol", genre: "Rock", bpm: 108, popularity: 7, key: "A major"),
        Song(id: "145", name: "The Way You Move", artist: "OutKast ft. Sleepy Brown", genre: "Hip Hop", bpm: 128, popularity: 7, key: "Bb minor"),
        Song(id: "146", name: "This Love", artist: "Maroon 5", genre: "Pop Rock", bpm: 104, popularity: 7, key: "C# minor"),
        Song(id: "147", name: "Take Me Out", artist: "Franz Ferdinand", genre: "Indie Rock", bpm: 118, popularity: 8, key: "D minor"),
        Song(id: "148", name: "Crazy in Love", artist: "Beyoncé", genre: "Pop", bpm: 99, popularity: 9, key: "C# minor"),
        Song(id: "149", name: "Seven Nation Army", artist: "The White Stripes", genre: "Rock", bpm: 124, popularity: 9, key: "E minor"),
        Song(id: "150", name: "Hey Ya!", artist: "Outkast", genre: "Pop", bpm: 160, popularity: 10, key: "G major")
    ]
