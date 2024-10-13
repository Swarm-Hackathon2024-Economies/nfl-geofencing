import SwiftUI
import MapKit

struct HomeScreen: View {
    
    var body: some View {
        ScrollView {
            VStack {
                HStack{
                    
                    Image("TitleIcon")
                    Spacer()
                    ZStack {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: 120, height: 30)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.red, lineWidth: 2)
                            )
                        
                        HStack {
                            Image("BallIcon")
                            Text("2,234")
                                .font(Font.title2)
                                .bold()
                        }
                    }
                    .cornerRadius(10)
                }
                .frame(maxWidth: 339)
                
                ZStack {
                    Image("CarImage").offset(y:-60)
                    Image("Profilecard")
                    VStack {
                        HStack {
                            Text("Rikuto")
                                .font(.title2)
                                .italic()
                                .bold()
                                .foregroundStyle(.white)
                            Spacer()
                            Text("34")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(.white)
                        }
                        .frame(maxWidth: 280)
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: Color.red, location: 0.7),
                                        .init(color: Color.gray, location: 0.7),
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: 280, height: 5)
                            .cornerRadius(2.5)
                        HStack {
                            Spacer()
                            Text("Next Level 580/650")
                                .foregroundStyle(.gray)
                        }
                        .frame(maxWidth: 280)
                        
                    }.offset(y:-250)
                    VStack (spacing:10){
                        HStack {
                            Text("League")
                                .foregroundStyle(.gray)
                                .font(.body)
                                .bold()
                            Spacer()
                            Text("College")
                                .foregroundStyle(.white)
                                .font(.body)
                                .bold()
                        }
                        HStack {
                            Text("Team")
                                .foregroundStyle(.gray)
                                .font(.body)
                                .bold()
                            Spacer()
                            Text("Toyota College")
                                .foregroundStyle(.white)
                                .font(.body)
                                .bold()
                        }
                        HStack {
                            Text("Points")
                                .foregroundStyle(.gray)
                                .font(.body)
                                .bold()
                            Spacer()
                            Text("12,345")
                                .foregroundStyle(.red)
                                .font(.body)
                                .bold()
                        }
                        HStack {
                            Text("Total Mileage")
                                .foregroundStyle(.gray)
                                .font(.body)
                                .bold()
                            Spacer()
                            Text("234miles")
                                .foregroundStyle(.white)
                                .font(.body)
                                .bold()
                        }
                        HStack {
                            Text("League Raking")
                                .foregroundStyle(.gray)
                                .font(.body)
                                .bold()
                            Spacer()
                            HStack (spacing:0){
                                Text("34th")
                                    .foregroundStyle(.white)
                                    .font(.body)
                                    .bold()
                                Text("/4982")
                                    .foregroundStyle(.gray)
                                    .font(.body)
                                    .bold()
                            }
                        }
                    }
                    .offset(y:180)
                    .frame(maxWidth: 280)
                }.padding(.bottom, 20)
                HStack {
                    Text("Ranking")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .bold()
                    Spacer()
                }
                .frame(maxWidth: 339)
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
                .frame(maxWidth: 339)
                VStack(spacing:10) {
                    let teams = Team.allItems.map { team in
                        (rank: "\(Team.allItems.firstIndex(of: team)! + 1)",
                         icon: team.image,
                         name: team.name,
                         points: "\(team.points.formattedWithSeparator())P")
                    }
                    ForEach(teams, id: \.rank) { team in
                        HStack(spacing:10) {
                            Text(team.rank)
                                .font(.title)
                                    .foregroundStyle(.indigo)
                                    .bold()
                                    .frame(width: 36, alignment: .center) // 幅を指定し、センターに配置
                                    .multilineTextAlignment(.center)
                            Image(team.icon)
                                .resizable()
                                       .aspectRatio(contentMode: .fit)
                                       .frame(maxWidth: 42, maxHeight: 36)
                                     
                            Text(team.name)
                                .font(.title2)
                                .bold()
                            Spacer()
                            Text(team.points)
                        }
                        .frame(height: 38)
                    }
                }
                .frame(maxWidth: 339)
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    HomeScreen()
}
extension Int {
    func formattedWithSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
