//
//  MoodModel.swift
//  MixMatch
//
//  Created by Asfandyar Khan on 4/4/23.
//

//import Foundation

//enum MoodCategory: String, CaseIterable, Identifiable {
//    var id: Self { self }
//    case party
//    case chill
//    case workout
//}

//class PlaylistGenerator: ObservableObject {
//    func generatePlaylist(songs: [Song], mood: MoodCategory) -> [Song] {
//        let filteredSongs = filterSongs(songs: songs, mood: mood)
//        let sortedSongs = sortSongs(songs: filteredSongs, mood: mood)
//
//        return sortedSongs
//    }
//
//    private func filterSongs(songs: [Song], mood: MoodCategory) -> [Song] {
//        switch mood {
//        case .party:
//            return songs.filter { ($0.bpm ?? 0) >= 120 && $0.key.contains("major") }
//        case .chill:
//            return songs.filter { ($0.bpm ?? 0) < 120 && $0.key.contains("minor") }
//        case .workout:
//            return songs.filter { ($0.bpm ?? 0) >= 130 }
//        }
//    }
//
//    private func sortSongs(songs: [Song], mood: MoodCategory) -> [Song] {
//        switch mood {
//        case .party:
//            return songs.sorted { ($0.popularity ?? 0) > ($1.popularity ?? 0) }
//        case .chill:
//            return songs.sorted { ($0.bpm ?? 0) < ($1.bpm ?? 0) }
//        case .workout:
//            return songs.sorted { ($0.bpm ?? 0) > ($1.bpm ?? 0) }
//        }
//    }
//}



//import Foundation
//
//enum MoodCategory: String, CaseIterable, Identifiable {
//    var id: Self { self }
//    case party
//    case chill
//    case workout
//}
//
//
//
//class PlaylistGenerator {
//
//    func generatePlaylist(songs: [Song], mood: MoodCategory) -> [Song] {
//        let filteredSongs = filterSongs(songs: songs, mood: mood)
//        let sortedSongs = sortSongs(songs: filteredSongs, mood: mood)
//        return sortedSongs
//    }
//
//    private func filterSongs(songs: [Song], mood: MoodCategory) -> [Song] {
//        switch mood {
//        case .party:
//            return songs.filter { $0.bpm >= 120 && $0.key.contains("major") }
//        case .chill:
//            return songs.filter { $0.bpm < 120 && $0.key.contains("minor") }
//        case .workout:
//            return songs.filter { $0.bpm >= 130 }
//        }
//    }
//
//    private func sortSongs(songs: [Song], mood: MoodCategory) -> [Song] {
//        switch mood {
//        case .party:
//            return songs.sorted { $0.popularity > $1.popularity }
//        case .chill:
//            return songs.sorted { $0.bpm < $1.bpm }
//        case .workout:
//            return songs.sorted { $0.bpm > $1.bpm }
//        }
//    }
//}
//
