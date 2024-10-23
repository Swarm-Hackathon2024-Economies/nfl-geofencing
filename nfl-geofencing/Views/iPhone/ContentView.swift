import SwiftUI

struct ContentView: View {
    @State private var finishOnboarding: Bool = false
    @State private var selectedTab = 0
    var body: some View {
        if finishOnboarding {
            DriveScreen()
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
