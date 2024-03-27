//
//  UserStore.swift
//  MixMatch
//
//  Created by Christian Garvin on 3/27/23.
//

import Foundation

class DataStore: ObservableObject {
    @Published var users: [User] = User.previewData
    @Published var friendsList: [User] = []
    
    func findUser(_ searchQuery: String) -> [User]{
        return users.filter{$0.username == searchQuery}
    }
    
    func addUserToFriendsList(_ user: User){
        friendsList.append(user)
    }
    
    func removeUserFromFriendsList(_ user: User){
        if let index = friendsList.firstIndex(where: { $0.id == user.id }) {
            friendsList.remove(at: index)
        }
    }
    func userIsFriend(_ user: User) -> Bool{
        if friendsList.firstIndex(where: { $0.id == user.id }) != nil{
            return true
        }
        else{
            return false
        }
    }
}
