import SwiftUI
enum SelectTeamView {
    case NFL
    case Collage
    case FlagFootball
    
}
struct RankingView: View {
    @State private var scrollOffset: CGFloat = 0
    @State private var selectedSection: SelectTeamView = .NFL
    
    var body: some View {
        VStack {
            Text("Ranking")
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                Section {
                    if selectedSection == .NFL {
                        Grid {
                            ForEach(Team.allItems, id: \.rank) { team in
                                GridRow {
                                    Text(team.rank)
                                        .font(.title.bold())
                                        .foregroundStyle(.indigo)
                                    Image(team.icon)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 46, maxHeight: 32)
                                    Text(team.name)
                                        .font(.title2.bold())
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(team.points)
                                }
                            }
                        }
                        .padding(.horizontal)
                    } else if selectedSection == .Collage {                                Grid {
                        ForEach(collageTeam.allItems, id: \.rank) { team in
                            GridRow {
                                Text(team.rank)
                                    .font(.title.bold())
                                    .foregroundStyle(.indigo)
                                Image(team.icon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 46, maxHeight: 32)
                                
                                Text(team.name)
                                    .font(.title2.bold())
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(team.points)
                            }
                        }
                    }
                    .padding(.horizontal)
                    } else  {                                Grid {
                        ForEach(flagFootballTeam.allItems, id: \.rank) { team in
                            GridRow {
                                Text(team.rank)
                                    .font(.title.bold())
                                    .foregroundStyle(.indigo)
                                Image(team.icon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: 46, maxHeight: 32)
                                
                                Text(team.name)
                                    .font(.title2.bold())
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(team.points)
                            }
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
    }
    var sectionHeader: some View {
        HStack {
                Text("NFL")
                    .foregroundStyle(selectedSection == .NFL ? .white : .red)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(
                selectedSection == .NFL ?
                Capsule().fill(.red)
                : Capsule().fill(.white)
            )
            .background(
                Capsule().stroke(.red)
            )
            .onTapGesture {
                selectedSection = .NFL
            }
            
            Text("Collage")
                .foregroundStyle(selectedSection == .Collage ? .white : .red)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(
                    selectedSection == .Collage ?
                    Capsule().fill(.red)
                    : Capsule().fill(.white)
                )
                .background(
                    Capsule().stroke(.red)
                )
                .onTapGesture {
                    selectedSection = .Collage
                }
            Text("FlagFootball")
                .foregroundStyle(selectedSection == .FlagFootball ? .white : .red)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(
                    selectedSection == .FlagFootball ?
                    Capsule().fill(.red)
                    : Capsule().fill(.white)
                )
                .background(
                    Capsule().stroke(.red)
                )
                .onTapGesture {
                    selectedSection = .FlagFootball
                }

            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(.thickMaterial.opacity(scrollOffset < 0 ? 1 : 0))
    }
}

#Preview {
    RankingView()
}
