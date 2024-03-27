import Foundation
import SwiftUI
import Combine
import FirebaseCore
import FirebaseAuth
import FirebaseDatabase

class DataStore: ObservableObject {
    @Published var users: [User] = User.previewData
    @Published var currentUserId: UUID = UUID()
    @Published var mixMatchFriends: [User] = []
    @Published var selectedSongs: [Song] = []
    @Published var user: User? = nil

    func getCurrentUser() -> User? {
        return users.first(where: { $0.id == currentUserId })
    }

    func getOtherUser(username: String) -> User? {
        if let index = users.firstIndex(where: { $0.username.lowercased() == username.lowercased() }) {
            return users[index]
        } else {
            return nil
        }
    }

    func addUserToFriendsList(_ user: User) {
        if let index = users.firstIndex(where: { $0.id == currentUserId }) {
            var thisUser = users[index]
            thisUser.friends.append(user)
            users[index] = thisUser
        }
    }

    func songIsInSelfPlaylist(_ song: Song) -> Bool {
        return selectedSongs.contains(song)
    }

    func removeUserFromFriendsList(_ user: User) {
        if let userIndex = users.firstIndex(where: { $0.id == currentUserId }) {
            var thisUser = users[userIndex]
            if let friendIndex = thisUser.friends.firstIndex(where: { $0.id == user.id }) {
                thisUser.friends.remove(at: friendIndex)
                users[userIndex] = thisUser
            }
        }
    }

    func userIsFriend(_ user: User) -> Bool {
        if getCurrentUser()?.friends.firstIndex(where: { $0.id == user.id }) != nil {
            return true
        } else if getCurrentUser() == nil {
            return false
        } else {
            return false
        }
    }

    func addNewUser(_ user: User) {
        Auth.auth().createUser(withEmail: user.username, password: user.password) { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
                return
            }
            self.currentUserId = user.id
            self.user = user

            let databaseRef = Database.database().reference()
            let userRef = databaseRef.child("users").child(user.username.lowercased())
            userRef.setValue(["name": user.name, "password": user.password])
        }
    }

    func signInUser(_ username: String) {
        Auth.auth().signIn(withEmail: username, password: getPassword(username)) { [weak self] result, error in
            guard let self = self else { return }
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                return
            }
            self.currentUserId = self.getCurrentUser()?.id ?? UUID()
            self.user = self.getCurrentUser()
        }
    }

    func signOutUser() {
        do {
            try Auth.auth().signOut()
            currentUserId = UUID()
            user = nil
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }

    func getPassword(_ username: String) -> String {
        let user = users.first(where: { $0.username.lowercased() == username })
        if user == nil {
            return ""
        }
        return user!.password
    }

    func addUserToMixMatch(_ user: User) {
        mixMatchFriends.append(user)
    }

    func removeUserFromMixMatch(_ user: User) {
        if let friendIndex = mixMatchFriends.firstIndex(where: { $0.id == user.id }) {
            mixMatchFriends.remove(at: friendIndex)
        }
    }

    func userIsInMixMatch(_ user: User) -> Bool {
        return mixMatchFriends.firstIndex(where: { $0.id == user.id }) != nil
    }

    func addSongToSelfPlaylist(_ song: Song) {
        selectedSongs.append(song)
    }

    func removeSongSelfPlaylist(_ song: Song) {
        if let songIndex = selectedSongs.firstIndex(where: { $0.name == song.name }) {
            selectedSongs.remove(at: songIndex)
        }
    }

    func mixMatch(_ playlistName: String, _ mood: MoodCategory, _ thisUser: User) {
        var allSongsInitial: [Song] = []
        mixMatchFriends.append(thisUser)

        for user in mixMatchFriends {
            for playlist in user.playlists.filter({ $0.mixedMatchedBy.isEmpty }) {
                for song in playlist.songs {
                    allSongsInitial.append(song)
                }
            }
        }

        let setOfSongs = Set(allSongsInitial)
        let allSongs = Array(setOfSongs)
        let newPlaylistSongs = generatePlaylist(songs: allSongs, mood: mood)
        let newPlaylist = Playlist(name: playlistName, songs: newPlaylistSongs, mixedMatchedBy: thisUser.username)

        for sharedUser in mixMatchFriends {
            addPlaylistToUser(sharedUser, newPlaylist)
        }

        mixMatchFriends = []
    }

    func addPlaylistToUser(_ user: User, _ newPlaylist: Playlist) {
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            var thisUser = users[index]
            thisUser.playlists.append(newPlaylist)
            users[index] = thisUser
        }
    }

    func generatePlaylist(songs: [Song], mood: MoodCategory) -> [Song] {
        let filteredSongs = filterSongs(songs: songs, mood: mood)
        let sortedSongs = sortSongs(songs: filteredSongs, mood: mood)
        return sortedSongs
    }

    func filterSongs(songs: [Song], mood: MoodCategory) -> [Song] {
        switch mood {
        case .party:
            return songs.filter { ($0.bpm ?? 0) >= 120 && $0.key.contains("major") }
        case .chill:
            return songs.filter { ($0.bpm ?? 0) < 120 && $0.key.contains("minor") }
        case .workout:
            return songs.filter { ($0.bpm ?? 0) >= 130 }
        }
    }

    func sortSongs(songs: [Song], mood: MoodCategory) -> [Song] {
        switch mood {
        case .party:
            return songs.sorted { ($0.popularity ?? 0) > ($1.popularity ?? 0) }
        case .chill:
            return songs.sorted { ($0.bpm ?? 0) < ($1.bpm ?? 0) }
        case .workout:
            return songs.sorted { ($0.bpm ?? 0) > ($1.bpm ?? 0) }
        }
    }
}

