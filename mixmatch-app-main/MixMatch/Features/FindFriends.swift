//
//  FindFriends.swift
//  MixMatch


import SwiftUI

struct FindFriends: View {
    @EnvironmentObject var dataStore: DataStore
    @State var searchQuery: String = ""
    
    var filteredUsers: [User] {
        if searchQuery.isEmpty {
            return dataStore.users.filter { $0.id != dataStore.getCurrentUser()?.id }
        } else {
            return dataStore.users.filter { $0.id != dataStore.getCurrentUser()?.id && $0.username.lowercased().contains(searchQuery.lowercased()) }
        }
    }

    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Find a Friend").font(.title)
                HStack{
                    Image(systemName: "magnifyingglass").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:30, height: 30)
                        .cornerRadius(6).padding(.leading, 10)
                    TextField("Search Username", text: $searchQuery).padding(10)
                }
                List(filteredUsers){ user in
                    NavigationLink(destination: UserProfile(user: user)){
                        UserRow(user: user)
                    }
                }
            }
        }
    }
}

struct UserRow: View {
    var user: User

    var body: some View {
        VStack(alignment: .leading) {
            Text(user.username)
            Text(user.name).bold()
        }
        .id(user.id) // Use the user's id as the identifier
    }
}

struct userList: View{
    @State var users: [User]
    var body: some View {
            List(users){ user in
                NavigationLink(destination: UserProfile(user: user)){
                    UserRow(user: user)
            }
        }
    }
    
}

struct FindFriends_Previews: PreviewProvider {
  static var previews: some View {
      FindFriends()
          .environmentObject(DataStore())
  }
}
