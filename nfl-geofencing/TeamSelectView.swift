import SwiftUI

struct TeamSelectView: View {
    @State private var selectedTeamIndex: Int?
    @Binding var isShowSetUpProfile: Bool
    
    private let teams = Team.allItems
    
    var body: some View {
        VStack {
            headerView(title: "Select Your")
            headerView(title: "Favorite NFL Team")
            
            Grid(horizontalSpacing: 9, verticalSpacing: 9) {
                ForEach(0 ..< (teams.count + 3) / 4, id: \.self) { rowIndex in
                    GridRow {
                        ForEach(0 ..< 4) { columnIndex in
                            let teamIndex = rowIndex * 4 + columnIndex
                            if teamIndex < teams.count {
                                teamCell(for: teams[teamIndex], isSelected: selectedTeamIndex == teamIndex)
                                    .onTapGesture {
                                        selectedTeamIndex = teamIndex
                                    }
                            } else {
                                Color.clear
                                    .frame(width: 77, height: 100)
                            }
                        }
                    }
                }
            }
            Spacer()
            Button(action: {
                isShowSetUpProfile = false
            }) {
                Text("Kick Off")
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).fill(.red))
            }
        }
        .frame(maxWidth: 334)
        Spacer()
    }
    
    
    private func headerView(title: String) -> some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .bold()
            Spacer()
        }
    }
    
    
    private func teamCell(for team: Team, isSelected: Bool) -> some View {
        VStack {
            Image(team.icon)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 57, maxHeight: 50)
            Text(team.name)
                .bold()
                .font(.caption)
            Circle()
                .fill(isSelected ? Color.red : Color.clear)
                .frame(width: 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(isSelected ? Color.red : Color.gray, lineWidth: 1)
                )
        }
        .frame(width: 77, height: 100)
        .background(Color.white.opacity(0.2))
        .cornerRadius(4)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.gray, lineWidth: 1)
        )
        
    }
}

#Preview {
    TeamSelectView(isShowSetUpProfile: .constant(true))
}
