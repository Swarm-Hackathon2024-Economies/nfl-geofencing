import SwiftUI

@main
struct nfl_geofencingApp: App {
    @StateObject private var scoreManager = ScoreManager()
    var body: some Scene {
        WindowGroup {
            if UIDevice.current.userInterfaceIdiom == .phone {
                ContentView()
                    .environmentObject(scoreManager)
            } else {
                IPadContentView()
            }
        }
    }
}
