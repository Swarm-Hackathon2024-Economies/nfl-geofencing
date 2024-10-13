import SwiftUI

struct CardsScreen: View {
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                    Section {
                        VStack(spacing: 27) {
                            NavigationLink {
                                CardCollectionDetailView()
                            } label: {
                                NFLCollectionOverview(title: "NFL Collection", imageName: "CollectionPicture1")
                                    .foregroundStyle(.black)
                            }
                            NFLCollectionOverview(title: "College Collection", imageName: "CollectionPicture2")
                            NFLCollectionOverview(title: "Profile Parts", imageName: "CollectionPicture3")
                        }
                        .padding(.horizontal)
                    } header: {
                        sectionHeader
                    }
                }
                .scrollSpy("ScrollView", scrollOffset: $scrollOffset)
            }
            .coordinateSpace(name: "ScrollView")
            .navigationTitle("")
            .cardsScreenToolbarItems()
        }
    }
    
    var sectionHeader: some View {
        HStack {
            HStack {
                Image(systemName: "football.fill")
                    .foregroundStyle(.red)
                    .font(.caption)
                    .padding(4)
                    .background(Circle().fill(.white))
                Text("Shop")
                    .foregroundStyle(.white)
            }
            .padding([.leading, .top, .bottom], 4)
            .padding(.trailing, 8)
            .background(Capsule().fill(.red))
            
            Text("My Collection")
                .foregroundStyle(.red)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Capsule().stroke(.red))
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(.thickMaterial.opacity(scrollOffset < 0 ? 1 : 0))
    }
}

struct CardsScreenToolbarItems: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("CardsTitleIcon")
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 38) {
                        Image(systemName: "football.fill")
                            .font(.caption)
                            .foregroundStyle(.white)
                            .padding(4)
                            .background(Circle().fill(.red))
                        Text("2,234")
                            .font(.title2)
                            .bold()
                    }
                    .padding(.trailing)
                    .padding([.leading, .top, .bottom], 4)
                    .background(Capsule().stroke(.secondary))
                }
            }
    }
}

extension View {
    func cardsScreenToolbarItems() -> some View {
        modifier(CardsScreenToolbarItems())
    }
}

#Preview {
    CardsScreen()
}
