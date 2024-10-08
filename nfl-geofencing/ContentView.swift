import SwiftUI

struct ContentView: View {
    @State private var finishOnboarding: Bool = true
    
    var body: some View {
        if finishOnboarding {
            TabView {
                HomeScreen()
                    .tabItem { Label("Home", systemImage: "house.fill") }
                MapScreen()
                    .tabItem { Label("Map", systemImage: "map.fill") }
                DriveScreen()
                    .tabItem { Label("Go", systemImage: "car.fill") }
                FriendScreen()
                    .tabItem { Label("Friend", systemImage: "person.3.fill") }
                MyPageScreen()
                    .tabItem { Label("My Page", systemImage: "person.circle.fill") }
            }
        } else {
            SetupProfileView() {
                finishOnboarding = true
            }
        }
    }
}

#Preview {
    ContentView()
}
