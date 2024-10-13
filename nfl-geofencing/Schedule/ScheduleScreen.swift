import SwiftUI

struct ScheduleScreen: View {
    private var teams: [(rank: String, icon: String, name: String, points: String, color: Color)] {
        Team.allItems.map { team in
            (
                rank: "\(Team.allItems.firstIndex(of: team)! + 1)",
                icon: team.image,
                name: team.name,
                points: "\(team.points.formattedWithSeparator())P",
                color: team.color
            )
        }
    }
    var body: some View {
        ScrollView{
            VStack (spacing:32){
                HStack {
                    Image("ScheduleTitleIcon")
                    Spacer()
                    ZStack {
                        Image("NotificationIcon")
                        ZStack {
                            Circle()
                                .fill(.red)
                                .frame(width: 20)
                            Text("1")
                                .foregroundStyle(.white)
                        }
                        .offset(x:8,y: -8)
                    }
                }
                HStack {
                    ZStack {
                        Rectangle()
                            .fill(.red)
                            .frame(width: 48, height: 30)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.red, lineWidth: 1)
                            )
                        Text("NFL")
                            .foregroundStyle(.white)
                            .font(.body)
                    }
                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .frame(width: 77, height: 30)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.red, lineWidth: 1)
                            )
                        Text("Collage")
                            .foregroundStyle(.red)
                            .font(.body)
                    }
                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .frame(width: 115, height: 30)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.red, lineWidth: 1)
                            )
                        Text("Flag FootBall")
                            .foregroundStyle(.red)
                            .font(.body)
                    }
                    Spacer()
                }
                HStack {
                    Text("Upcoming Games")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                VStack (spacing:10){
                    VStack {
                        HStack {
                            Text("Friday, October 11")
                                .font(.body)
                                .bold()
                                .padding(.bottom, 10)
                            Spacer()
                        }
                        teamRectangle(for: teams[0], and: teams[1])
                    }
                    VStack {
                        HStack {
                            Text("Saturday, October 12")
                                .font(.body)
                                .bold()
                                .padding(.vertical, 10)
                            Spacer()
                        }
                        teamRectangle(for: teams[2], and: teams[3])
                    }
                    VStack {
                        HStack {
                            Text("Sunday, October 13")
                                .font(.body)
                                .bold()
                                .padding(.vertical, 10)
                            Spacer()
                        }
                        teamRectangle(for: teams[4], and: teams[5])
                    }
                }
            }
            .frame(width: 351)
        }
    }
}

#Preview {
    ScheduleScreen()
}
private func teamRectangle(for team1: (rank: String, icon: String, name: String, points: String, color: Color),
                           and team2: (rank: String, icon: String, name: String, points: String, color: Color)) -> some View {
    RoundedRectangle(cornerRadius: 10)
        .fill(Color.white)
        .frame(width: 351, height: 150)
        .shadow(color: .gray, radius: 5, x: 0, y: 5)
        .overlay(
            VStack(spacing: 16) {
                HStack {
                    Rectangle()
                        .fill(team1.color)
                        .frame(width: 4, height: 30)
                        .padding()
                    Image(team1.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 42, maxHeight: 36)
                    Text(team1.name)
                        .font(.title3)
                        .italic()
                        .bold()
                    Spacer()
                    Text("2-3")
                        .bold()
                        .foregroundStyle(.gray)
                        .padding()
                }
                .frame(height: 30)
                HStack {
                    Rectangle()
                        .fill(team2.color)
                        .frame(width: 4, height: 30)
                        .padding()
                    Image(team2.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 42, maxHeight: 36)
                    Text(team2.name)
                        .font(.title3)
                        .italic()
                        .bold()
                    Spacer()
                    Text("4-1")
                        .bold()
                        .foregroundStyle(.gray)
                        .padding()
                }
                .frame(height: 30)
                Text("9:50 am")
                    .bold()
                    .foregroundStyle(.gray)
            }
        )
}
