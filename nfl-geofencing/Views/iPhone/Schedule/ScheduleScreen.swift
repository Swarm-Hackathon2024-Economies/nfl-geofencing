import SwiftUI

struct ScheduleScreen: View {
    @State private var scrollOffset: CGFloat = 0
    @State private var selectedSection: SelectTeamView = .NFL
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack (spacing: 0, pinnedViews: .sectionHeaders) {
                    Section {
                        VStack(spacing: 24) {
                            Text("Upcoming Games")
                                .font(.title2.bold())
                                .frame(maxWidth: .infinity, alignment: .leading)
                            if selectedSection == .NFL {
                                VStack {
                                    Text("Friday, October 11")
                                        .font(.body.bold())
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    MatchCard(for: Team.allItems[0], and: Team.allItems[1], and: 0)
                                }
                                
                                VStack {
                                    Text("Saturday, October 12")
                                        .font(.body.bold())
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    MatchCard(for: .allItems[2], and: Team.allItems[3], and: 1)
                                }
                                
                                VStack {
                                    Text("Sunday, October 13")
                                        .font(.body.bold())
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    MatchCard(for: Team.allItems[4], and: Team.allItems[5], and:2)
                                }
                            } else if selectedSection == .Collage {
                                VStack {
                                    Text("Monday, October 14")
                                        .font(.body.bold())
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    MatchCard(for: collageTeam.allItems[0], and: collageTeam.allItems[1], and:2)
                                }
                                
                                VStack {
                                    Text("Friday, October 18")
                                        .font(.body.bold())
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    MatchCard(for: collageTeam.allItems[2], and: collageTeam.allItems[3], and:0)
                                }
                                
                                VStack {
                                    Text("Saturday, October 19")
                                        .font(.body.bold())
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    MatchCard(for: collageTeam.allItems[4], and: collageTeam.allItems[5], and:1)
                                }
                            } else {
                                VStack {
                                    Text("Sunday, September 20")
                                        .font(.body.bold())
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    MatchCard(for: flagFootballTeam.allItems[0], and: flagFootballTeam.allItems[1], and:1)
                                }
                                
                                VStack {
                                    Text("Sunday, September 27")
                                        .font(.body.bold())
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    MatchCard(for: flagFootballTeam.allItems[2], and: flagFootballTeam.allItems[3], and:2)
                                }
                                
                                VStack {
                                    Text("Saturday, October 2")
                                        .font(.body.bold())
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    MatchCard(for: flagFootballTeam.allItems[4], and: flagFootballTeam.allItems[5], and:0)
                                }
                            }
                        }
                        .padding()
                    } header: {
                        sectionHeader
                    }
                }
                .scrollSpy("ScheduleScrollView", scrollOffset: $scrollOffset)
            }
            .coordinateSpace(name: "ScheduleScrollView")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("ScheduleTitleIcon")
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Image("NotificationIcon")
                        .overlay {
                            Text("1")
                                .foregroundStyle(.white)
                                .padding(6)
                                .background(Circle().fill(.red))
                                .offset(x: 8, y: -8)
                        }
                }
            }
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
    ScheduleScreen()
}

