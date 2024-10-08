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
                HStack {
                    Button("行先") {
                        self.currentPage = page.destination
                    }
                    Button("リスト") {
                        self.currentPage = page.list
                    }
                }
                switch currentPage {
                case .destination:
                    VStack {
                        RouteDetailView()
                        Spacer()
                    }
                case .list:
                    List{
                        NavigationLink {
                            RouteDetailView()
                        } label: {
                            Text("ハワイ")
                        }
                        NavigationLink {
                            RouteDetailView()
                        } label: {
                            Text("テキサス")
                        }
                        NavigationLink {
                            RouteDetailView()
                        } label: {
                            Text("ネバダ")
                        }
                    }
                    .navigationBarItems(
                        trailing: Button(action: {
                            self.isShowAddSheet = true
                        }) {
                            Image(systemName: "plus")
                        }
                    )
                }
            }
            .sheet(isPresented: $isShowAddSheet) {
                DestinationRegistorView(onSubmit: {
                    isShowAddSheet = false
                })
            }
        }
    }
}

#Preview {
    DriveScreen()
}
