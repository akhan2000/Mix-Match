//
//  AppleMusicApi.swift
//  MixMatch
//
//  Created by Asfandyar Khan on 4/4/23.
//

import Foundation

class AppleMusicAPI {
    private let developerToken = "eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IlE2Mk5CVFdZTlQifQ.eyJpc3MiOiJVNko1OEM4Q0pUIiwiaWF0IjoxNjgzOTU5MzUzLCJleHAiOjE2ODM5NjI5NTN9.apMJAWraMgtDzhX9rJpgrd0vndpS5bINRVFE8DIthprWGdFRoDa6OeYcQkhFzOu2eaKmWQURcdiLP7UjZwA_Bg"
    private let baseUrl = "https://api.music.apple.com/v1/"
    private let session = URLSession.shared
    
    
    func getTopSongs(completion: @escaping ([Song]?) -> Void) {
        let url = URL(string: "\(baseUrl)catalog/us/charts?types=songs")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")

        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(APIResponse.self, from: data)
                let songs = apiResponse.results.songs.data.map { songData -> Song in
                    return Song(
                        id: songData.id,
                        name: songData.attributes.name,
                        artist: songData.attributes.artistName,
                        genre: songData.attributes.genreNames.joined(separator: ", "),
                        coverUrl: URL(string: songData.attributes.artwork.url),
                        bpm: 0,
                        popularity: 0,
                        key: ""
                    )
                }
                completion(songs)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }

    


    func searchSongs(songName: String, completion: @escaping ([Song]?) -> Void) {
        let encodedSongName = songName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: "\(baseUrl)catalog/us/songs?filter[term]=\(encodedSongName)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")

        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(APIResponse.self, from: data)
                let songs = apiResponse.results.songs.data.map { songData -> Song in
                    return Song(
                        id: songData.id,
                        name: songData.attributes.name,
                        artist: songData.attributes.artistName,
                        genre: songData.attributes.genreNames.joined(separator: ", "),
                        coverUrl: URL(string: songData.attributes.artwork.url),
                        bpm: 0,  // Apple Music API does not provide BPM
                        popularity: 0,  // Apple Music API does not provide popularity
                        key: ""  // Apple Music API does not provide key
                    )
                

                }
                completion(songs)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(nil)
            }
        }
        task.resume()
    }
}


