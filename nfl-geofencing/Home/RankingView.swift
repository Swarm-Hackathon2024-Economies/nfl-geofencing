import SwiftUI

struct RankingView: View {
    let teams = Team.allItems.map { team in
        (rank: "\(Team.allItems.firstIndex(of: team)! + 1)",
         icon: team.image,
         name: team.name,
         points: "\(team.points.formattedWithSeparator())P")
    }
    
    var body: some View {
        VStack {
            Text("Ranking")
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                CapsuleButton("NFL", style: .filled)
                CapsuleButton("Collage")
                CapsuleButton("Flag FootBall")
                Spacer()
            }
            Grid {
                ForEach(teams, id: \.rank) { team in
                    GridRow {
                        Text(team.rank)
                            .font(.title.bold())
                            .foregroundStyle(.indigo)
                        Image(team.icon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 42, maxHeight: 36)
                        
                        Text(team.name)
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(team.points)
                    }
                }
            }
        }
    }
}

#Preview {
    RankingView()
}
