import SwiftUI

struct DriveScreen: View {
    enum page {
        case destination
        case list
    }

    @State private var currentPage = page.destination
    @State private var isShowAddSheet: Bool = false

    var body: some View {
        NavigationStack{
            VStack {
                RouteDetailView()
                Spacer()
            }
        }
        .sheet(isPresented: $isShowAddSheet) {
            DestinationRegistorView(onSubmit: {
                isShowAddSheet = false
            })
        }
    }
}

#Preview {
    DriveScreen()
}
