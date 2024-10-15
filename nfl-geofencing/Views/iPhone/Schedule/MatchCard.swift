import SwiftUI


struct MatchCard: View {
    let team1: Team
    let team2: Team
    
    init(for team1: Team, and team2: Team) {
        self.team1 = team1
        self.team2 = team2
    }
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Rectangle()
                    .fill(team1.color)
                    .frame(width: 4, height: 30)
                Image(team1.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 42, maxHeight: 36)
                Text(team1.name)
                    .font(.title3.bold()).italic()
                Spacer()
                Text("2-3")
                    .bold()
                    .foregroundStyle(.gray)
            }
            
            HStack {
                Rectangle()
                    .fill(team2.color)
                    .frame(width: 4, height: 30)
                Image(team2.icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 42, maxHeight: 36)
                Text(team2.name)
                    .font(.title3.bold()).italic()
                Spacer()
                Text("4-1")
                    .bold()
                    .foregroundStyle(.gray)
            }
            
            Text("9:50 am")
                .bold()
                .foregroundStyle(.gray)
        }
        .padding([.vertical, .trailing])
        .padding(.leading, 4)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.white)
                .shadow(color: .gray, radius: 5, x: 0, y: 5)
        )
    }
}

#Preview {
    MatchCard(for: Team.allItems[0], and: Team.allItems[1])
}
