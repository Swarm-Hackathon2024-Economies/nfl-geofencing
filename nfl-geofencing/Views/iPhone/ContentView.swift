import SwiftUI

struct ContentView: View {
    @State private var finishOnboarding: Bool = false
    @State private var selectedTab = 0
    var body: some View {
        if finishOnboarding {
            TabView(selection: $selectedTab) {
                HomeScreen()
                    .tabItem {
                        if selectedTab == 0 {
                            Image("Home_select")
                        } else {
                            Image("Home")
                        }
                    }
                    .tag(0)
                
                DriveScreen()
                    .tabItem {
                            Image("Drive")
                    }
                    .tag(1)

                MyPageScreen()
                    .tabItem {
                        if selectedTab == 2 {
                            Image("Mypage_select")
                        } else {
                            Image("Mypage")
                        }
                    }
                    .tag(2)
            }
        } else {
            LoginView() {
                finishOnboarding = true
            }
            .preferredColorScheme(.light)
        }
    }
}

#Preview {
    ContentView()
}
