import SwiftUI
import MapKit

struct HomeScreen: View {
    @EnvironmentObject var scoreManager: ScoreManager
    @State private var isImageVisible = false
    @State private var isScoreVisible = true

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
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 36)
                        .zIndex(10)
                        .scaleEffect(isImageVisible ? 1.0 : 500, anchor: .init(x: 0.7, y: 0.35))
                        .animation(.easeInOut(duration: 0.5), value: isImageVisible)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                        isImageVisible = true
                                    }
                                }
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
                    .opacity(isScoreVisible ? 0 : 1)
                    .animation(.easeInOut(duration: 1.5), value: isScoreVisible)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.5)) {
                                    isScoreVisible = false
                                }
                            }
                    
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
