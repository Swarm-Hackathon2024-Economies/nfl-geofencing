import SwiftUI

struct IPadContentView: View {
    @State private var navigationBarSelection: ToyotaNaviSidebar.Item = .map
    
    var body: some View {
        RouteNavigationView()
            .toyotaNaviSidebar(selection: $navigationBarSelection)
    }
}

#Preview {
    IPadContentView()
}
