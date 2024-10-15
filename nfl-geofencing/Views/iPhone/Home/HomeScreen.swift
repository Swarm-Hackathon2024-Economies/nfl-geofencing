import SwiftUI
import MapKit

struct HomeScreen: View {
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ProfileCardView()
                    RankingView()
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("TitleIcon")
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 32) {
                        Image(systemName: "football.fill")
                            .font(.caption)
                            .padding(4)
                            .foregroundStyle(.white)
                            .background(Circle().fill(.red))
                        
                        Text("2,234")
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
    HomeScreen()
}
