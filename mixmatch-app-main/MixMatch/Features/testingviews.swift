//
//  testingviews.swift
//  MixMatch
//
//  Created by Asfandyar Khan on 4/25/23.
//

import SwiftUI
import Foundation
import AVFoundation

struct TestingViews: View {
    @State private var songName = ""
    @State private var songs: [Song] = []
    @State private var isLoading = false
    @State private var isSearchTapped = false
    private let api = AppleMusicAPI()
    
    var body: some View {
        VStack {
            TextField("Enter song name", text: $songName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                isSearchTapped = true
                fetchSongDetails()
            }) {
                Text("Search")
            }
            .padding()
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            } else if songs.isEmpty && isSearchTapped && !songName.isEmpty {
                Text("No results found")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                List(songs) { song in
                    NavigationLink(destination: SongDetailsView(song: song)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(song.name)
                                    .font(.headline)
                                Text(song.artist ?? "")
                                    .font(.subheadline)
                            }
                            Spacer()
                            Image(systemName: "play.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 32, height: 32)
                        }
                    }
                }
            }
        }
    }
        
        
        
        
        
        
        
        
        func fetchSongDetails() {
            songs = []
            isLoading = true
            
            let developerToken = "eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IlE2Mk5CVFdZTlQifQ.eyJpc3MiOiJVNko1OEM4Q0pUIiwiaWF0IjoxNjgzOTU5MzUzLCJleHAiOjE2ODM5NjI5NTN9.apMJAWraMgtDzhX9rJpgrd0vndpS5bINRVFE8DIthprWGdFRoDa6OeYcQkhFzOu2eaKmWQURcdiLP7UjZwA_Bg" // Replace with your actual developer token
            let storefront = "us" // Replace with the appropriate storefront code
            let encodedSongName = songName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = URL(string: "https://api.music.apple.com/v1/catalog/\(storefront)/search?term=\(encodedSongName)&types=songs")!
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                    return
                }
                
                do {
                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                    let songs = apiResponse.results.songs.data.map { songData -> Song in
                        return Song(
                            id: songData.id,
                            name: songData.attributes.name,
                            artist: songData.attributes.artistName,
                            genre: songData.attributes.genreNames.joined(separator: ", "),
                            coverUrl: URL(string: songData.attributes.artwork.url.replacingOccurrences(of: "{w}x{h}", with: "500x500")),
                            bpm: 0,  // Apple Music API does not provide BPM
                            popularity: 0,  // Apple Music API does not provide popularity
                            key: ""  // Apple Music API does not provide key
                        )
                    }
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.songs = songs
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
            }
            task.resume()
        }
    
        
        
        struct TestingViews_Previews: PreviewProvider {
            static var previews: some View {
                TestingViews()
                    .environmentObject(DataStore())
            }
        }
        
        struct SongDetailsView: View {
            let song: Song
            
            var body: some View {
                VStack {
                    Text(song.name)
                    Text(song.artist ?? "")
                }
            }
        }
        
    }
    

