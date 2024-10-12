import SwiftUI

struct Instruction {
    var text: String?
    var direction: Double?
}

struct IPadContentView: View {
    @ObservedObject private var locationManager = FakeLocationManager()
    @State private var navigationBarSelection: ToyotaNaviSidebar.Item = .map
    @State private var totalPoints: Int = 0
    @State private var instruction: Instruction = Instruction(text: nil, direction: nil)
    
    var body: some View {
        ZStack {
            RouteNavigationView(
                locationManager: locationManager,
                instruction: $instruction,
                totalPoints: $totalPoints
            )
            .toyotaNaviSidebar(selection: $navigationBarSelection)
            .overlay(alignment: .bottomTrailing) {
                currentScoreCard
            }
            .overlay(alignment: .topTrailing) {
                HStack {
                    if let instructionText = instruction.text {
                        Text(instructionText)
                    } else {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
                .mapFloatingItemBackground()
            }
            
            if locationManager.updatingFinished {
                ResultDialog(resultPoints: totalPoints)
                    .transition(.scale.combined(with: .opacity))
            }
        }
    }
    
    var currentScoreCard: some View {
        VStack {
            Image("Eagles")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 80)
            HStack {
                Image(systemName: "football.fill")
                    .foregroundStyle(.black)
                    .padding(4)
                    .background(Circle().fill(.white))
                Text("Points").italic().font(.title3)
                Spacer()
                Text("+\(totalPoints)")
                    .contentTransition(.numericText())
                    .font(.largeTitle.bold())
            }
        }
        .mapFloatingItemBackground()
    }
}

fileprivate struct MapFloatingItemBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .background(RoundedRectangle(cornerRadius: 16).fill(.black))
            .frame(maxWidth: 300)
    }
}

fileprivate extension View {
    func mapFloatingItemBackground() -> some View {
        modifier(MapFloatingItemBackground())
    }
}

#Preview {
    IPadContentView()
}
