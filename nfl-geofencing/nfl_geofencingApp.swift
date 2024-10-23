import SwiftUI

@main
struct nfl_geofencingApp: App {
    @StateObject private var scoreManager = ScoreManager()
    @State private var isShowSplash = true
    var body: some Scene {
        WindowGroup {
            if isShowSplash {
                SplashScreen(isShowSplash: $isShowSplash)
            } else if UIDevice.current.userInterfaceIdiom == .phone {
                ContentView()
                    .environmentObject(scoreManager)
            } else {
                IPadContentView()
            }
        }
    }
}
