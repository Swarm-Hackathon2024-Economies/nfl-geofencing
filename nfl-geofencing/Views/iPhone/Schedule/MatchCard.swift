import SwiftUI


struct MatchCard: View {
    let team1: Team
    let team2: Team
    let index: Int
    
    init(for team1: Team, and team2: Team, and index: Int) {
        self.team1 = team1
        self.team2 = team2
        self.index = index
    }
    let scoreArray = [["2-3", "4-1"], ["1-1", "3-1"], ["3-2", "0-1"]]
    let timeArray = ["11:50 am", "1:30 pm", "9:50 pm"]
    
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
                Text(scoreArray[index][0])
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
                Text(scoreArray[index][1])
                    .bold()
                    .foregroundStyle(.gray)
            }
            
            Text(timeArray[index])
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
    MatchCard(for: Team.allItems[0], and: Team.allItems[1], and: 0)
}
