import SwiftUI

struct Instruction {
    var text: String?
    var distance: Int?
}

struct IPadContentView: View {
    @ObservedObject private var locationManager = FakeLocationManager()
    @State private var navigationBarSelection: ToyotaNaviSidebar.Item = .map
    @State private var totalPoints: Int = 0
    @State private var instruction: Instruction = Instruction(text: nil, distance: nil)
    @ObservedObject var mcSessionManager = MCSessionManager()
    @State private var navigationStarted = false
    
    var body: some View {
        ZStack {
            RouteNavigationView(
                locationManager: locationManager,
                instruction: $instruction,
                totalPoints: $totalPoints,
                navigationStarted: $navigationStarted
            )
            .toyotaNaviSidebar(selection: $navigationBarSelection)
            .overlay(alignment: .bottomTrailing) {
                currentScoreCard
                    .opacity(navigationStarted ? 1 : 0)
            }
            .overlay(alignment: .topTrailing) {
                HStack {
                    if let instructionText = instruction.text, let instructionDistance = instruction.distance {
                        VStack {
                            Text("\(instructionDistance)m away")
                                .font(.title.bold())
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .contentTransition(.numericText())
                            Capsule().fill(.white).frame(maxWidth: .infinity, maxHeight: 1)
                            Text(instructionText)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        Image(systemName: selectSymbol(for: instructionText) ?? "")
                            .font(.largeTitle.bold())
                            .foregroundStyle(.blue)
                    } else {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
                .mapFloatingItemBackground(width: 400)
                .opacity(navigationStarted ? 1 : 0)
            }
            .overlay(alignment: .bottomLeading) {
                if let peerId = mcSessionManager.connectedPeerID {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                        Text("Connected - \(peerId.displayName)")
                    }
                    .mapFloatingItemBackground(width: 300)
                } else {
                    HStack {
                        Image(systemName: "xmark.circle.fill")
                        Text("No connection")
                    }
                    .mapFloatingItemBackground(width: 300)
                }
            }
            .onAppear {
                mcSessionManager.startAdvertising()
            }
            .onDisappear {
                mcSessionManager.invalidate()
            }
            .onChange(of: mcSessionManager.receivedData) { _, newValue in
                guard let data = newValue else { return }
                guard let navigationStarted = try? JSONDecoder().decode(Bool.self, from: data) else { return }
                self.navigationStarted = navigationStarted
                mcSessionManager.invalidate()
            }
            
            if locationManager.updatingFinished {
                ResultDialog(resultPoints: totalPoints)
                    .transition(.scale.combined(with: .opacity))
            }
        }
    }
    
    var currentScoreCard: some View {
        VStack {
            HStack {
                Image(systemName: "heart.fill")
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
        .mapFloatingItemBackground(width: 300)
    }
    
    private func selectSymbol(for instructionText: String) -> String? {
        if instructionText.contains("left") {
            return "arrow.turn.up.left"
        } else if instructionText.contains("right") {
            return "arrow.turn.up.right"
        } else if instructionText.contains("exit") {
            return "arrow.turn.up.right"
        } else if instructionText.contains("Arrive") {
            return "checkmark.circle"
        }
        return nil
    }
}

fileprivate struct MapFloatingItemBackground: ViewModifier {
    let width: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
            .background(RoundedRectangle(cornerRadius: 16).fill(.black))
            .frame(maxWidth: width)
            .padding()
    }
}

fileprivate extension View {
    func mapFloatingItemBackground(width: CGFloat) -> some View {
        modifier(MapFloatingItemBackground(width: width))
    }
}

#Preview {
    IPadContentView()
}
