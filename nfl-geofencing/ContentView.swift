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
                        
                        MapScreen()
                            .tabItem {
                                if selectedTab == 1 {
                                    Image("Schedule_select")
                                } else {
                                    Image("Schedule")
                                }
                            }
                            .tag(1)
                        
                        DriveScreen()
                            .tabItem {
                                    Image("Drive")
                            }
                            .tag(2)
                        
                        FriendScreen()
                            .tabItem {
                                if selectedTab == 3 {
                                    Image("Card_select")
                                } else {
                                    Image("Card")
                                }
                            }
                            .tag(3)
                        
                        MyPageScreen()
                            .tabItem {
                                if selectedTab == 4 {
                                    Image("Mypage_select")
                                } else {
                                    Image("Mypage")
                                }
                            }
                            .tag(4)
                    }
        } else {
            LoginView() {
                finishOnboarding = true
            }
        }
    }
}

#Preview {
    ContentView()
}
