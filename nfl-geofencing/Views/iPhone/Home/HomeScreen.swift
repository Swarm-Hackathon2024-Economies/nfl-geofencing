import SwiftUI
import MapKit

struct HomeScreen: View {
    @EnvironmentObject var scoreManager: ScoreManager

    var body: some View {
        NavigationStack {
            VStack {
                ProfileCardView()
            }
            .padding()
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    Image("TitleIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 168, height: 54)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 32) {
                        Image(systemName: "football.fill")
                            .font(.caption)
                            .padding(4)
                            .foregroundStyle(.white)
                            .background(Circle().fill(.red))

                        Text("\(scoreManager.score)")
                            .font(Font.title2)
                            .bold()
                    }
                    .padding([.leading, .top, .bottom], 4)
                    .padding(.trailing, 8)
                    .background(Capsule().stroke(.secondary))
                }
            }
        }
    }
}

extension Int {
    func formattedWithSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

#Preview {
    HomeScreen().environmentObject(ScoreManager())
}
