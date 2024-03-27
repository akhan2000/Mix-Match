import Firebase
import SwiftUI

@main
struct MixMatchApp: App {
    @StateObject var dataStore = DataStore()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(dataStore)
        }
    }

    init() {
        FirebaseApp.configure()
    }
}
