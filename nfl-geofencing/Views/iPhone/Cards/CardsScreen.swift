import SwiftUI

enum SelectCardsView {
    case Shop
    case MyCollection
}

struct CardsScreen: View {
    @State private var scrollOffset: CGFloat = 0
    @State private var selectedSection: SelectCardsView = .Shop
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                    Section {
                        if selectedSection == .Shop {
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
                        } else {                                MyCollectionView()
                                .padding(.horizontal)
                        }
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
                    .resizable()
                    .foregroundStyle(.red)
                    .font(.caption)
                    .padding(4)
                    .background(Circle().fill(.white))
                    .frame(width: 18, height: 20)
                Text("Shop")
                    .foregroundStyle(selectedSection == .Shop ? .white : .red)
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(
                selectedSection == .Shop ?
                Capsule().fill(.red)
                : Capsule().fill(.white)
            )
            .background(
                Capsule().stroke(.red)
            )
            .onTapGesture {
                selectedSection = .Shop
            }
            
            Text("My Collection")
                .foregroundStyle(selectedSection == .MyCollection ? .white : .red)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(
                    selectedSection == .MyCollection ?
                    Capsule().fill(.red)
                    : Capsule().fill(.white)
                )
                .background(
                    Capsule().stroke(.red)
                )
                .onTapGesture {
                    selectedSection = .MyCollection
                }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(.thickMaterial.opacity(scrollOffset < 0 ? 1 : 0))
    }
}

struct CardsScreenToolbarItems: ViewModifier {
    @EnvironmentObject var scoreManager: ScoreManager
    
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
                        Text("\(scoreManager.score)")
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
    CardsScreen().environmentObject(ScoreManager())
}
