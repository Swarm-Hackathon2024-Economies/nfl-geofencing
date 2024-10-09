import SwiftUI

@main
struct nfl_geofencingApp: App {
    var body: some Scene {
        WindowGroup {
            if UIDevice.current.userInterfaceIdiom == .phone {
                ContentView()
            } else {
                IPadContentView()
            }
        }
    }
}
