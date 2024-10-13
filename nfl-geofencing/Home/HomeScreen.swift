import SwiftUI
import MapKit

struct HomeScreen: View {
    
    var body: some View {
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
                        .font(Font.title)
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
            }
        }
    }
}

#Preview {
    HomeScreen()
}
