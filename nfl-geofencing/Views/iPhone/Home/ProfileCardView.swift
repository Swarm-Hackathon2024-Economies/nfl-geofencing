import SwiftUI

struct ProfileCardView: View {
    var body: some View {
        ZStack {
            Image("CarImage")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(0.83)
                .offset(y:-66)
            
            Image("Profilecard")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .overlay(alignment: .top) {
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
                Capsule().fill(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color.red, location: 0.7),
                            .init(color: Color.gray, location: 0.7),
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(height: 5)
                Text("Next Level 580/650")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundStyle(.gray)
            }
            .padding()
            .padding(.horizontal)
        }
        .overlay(alignment: .bottom) {
            VStack (spacing: 16) {
                profileRow("League", contentText: "College")
                profileRow("Team", contentText: "Toyota College")
                profileRow("Points", contentText: "12,345", contentForeground: .red)
                profileRow("Total Mileage", contentText: "234miles")
                profileRow("League Raking") {
                    HStack (spacing:0){
                        Text("34th")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .bold()
                        Text("/4982")
                            .foregroundStyle(.gray)
                            .font(.title3)
                            .bold()
                    }
                }
            }
            .padding()
            .padding()
        }
    }
    
    func profileRow(
        _ title: String,
        contentText: String? = nil,
        contentForeground: Color = .white,
        content: () -> some View = { EmptyView() }
    ) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(.gray)
                .font(.title3)
                .bold()
            Spacer()
            content()
            if let contentText {
                Text(contentText)
                    .foregroundStyle(contentForeground)
                    .font(.title3)
                    .bold()
            }
        }
    }
}

#Preview {
    ProfileCardView()
}
