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
                        } else {
                            VStack {
                                HStack {
                                    Text("NFL Collections")
                                        .font(.title2.bold())
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    HStack{
                                        Text("23")
                                            .font(.title2.bold())
                                        Text("/ 230")
                                    }
                                }
                                HStack {
                                    NavigationLink {
                                        PlayerCard()
                                    } label: {
                                        Image("MyNFLCollection1")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                            .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                                    }
                                    Image("MyNFLCollection2")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                                    Image("MyNFLCollection1")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                                }
                                HStack {
                                    Spacer()
                                    Text("View all")
                                        .font(.title3.bold())
                                        .foregroundStyle(.red)
                                }
                                .padding(.bottom, 10)
                                HStack {
                                    Text("College Collections")
                                        .font(.title2.bold())
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("40")
                                        .font(.title2.bold())
                                    Text("/ 230")
                                }
                                HStack {
                                    Image("MyCollegeCollection1")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                                    Image("MyCollegeCollection2")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                                    Image("MyCollegeCollection1")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                        .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                                }
                                HStack {
                                    Spacer()
                                    Text("View all")
                                        .font(.title3.bold())
                                        .foregroundStyle(.red)
                                }
                            }
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
                    .foregroundStyle(.red)
                    .font(.caption)
                    .padding(4)
                    .background(Circle().fill(.white))
                Text("Shop")
                    .foregroundStyle(selectedSection == .Shop ? .white : .red)
            }
            .padding([.leading, .top, .bottom], 4)
            .padding(.trailing, 8)
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
                .padding(.horizontal, 8)
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
