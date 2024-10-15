import SwiftUI

struct ScheduleScreen: View {
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack (spacing: 0, pinnedViews: .sectionHeaders) {
                    Section {
                        VStack(spacing: 24) {
                            Text("Upcoming Games")
                                .font(.title2.bold())
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            VStack {
                                Text("Friday, October 11")
                                    .font(.body.bold())
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                MatchCard(for: Team.allItems[0], and: Team.allItems[1])
                            }
                            
                            VStack {
                                Text("Saturday, October 12")
                                    .font(.body.bold())
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                MatchCard(for: Team.allItems[2], and: Team.allItems[3])
                            }
                            
                            VStack {
                                Text("Sunday, October 13")
                                    .font(.body.bold())
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                MatchCard(for: Team.allItems[4], and: Team.allItems[5])
                            }
                        }
                        .padding()
                    } header: {
                        HStack {
                            CapsuleButton("NFL", style: .filled)
                            CapsuleButton("Collage")
                            CapsuleButton("Flag Football")
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                        .background(.thickMaterial.opacity(scrollOffset < 0 ? 1 : 0))
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
}

#Preview {
    ScheduleScreen()
}

