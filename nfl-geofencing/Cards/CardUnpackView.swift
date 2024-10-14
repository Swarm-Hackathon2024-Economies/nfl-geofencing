import SwiftUI

struct CardUnpackView: View {
    @Binding var show: Bool
    @State private  var cardPresented = false
    @State private var showOKButton = false
    @State private var showRank = false
    let backgroundAnimationPhases: [Color] = [.blue, .red, .orange, .yellow, .purple, .mint, .pink]
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Rectangle()
                    .frame(height: 500)
                    .phaseAnimator(backgroundAnimationPhases) { content, phase in
                        content
                            .overlay(phase.opacity(0.7))
                            .blur(radius: 150)
                    } animation: { _ in .easeInOut(duration: 1.5) }
                Spacer()
            }
            .background(.black)
            
            PlayerCard()
                .overlay {
                    RoundedRectangle(cornerRadius: 50)
                        .fill(
                            .linearGradient(
                                colors: [.white, .gray, .white, .gray, .white],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .opacity(cardPresented ? 0 : 1)
                }
                .rotation3DEffect(.degrees(cardPresented ? 3600 : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
                .scaleEffect(cardPresented ? 0.9 : 0.3)
                .offset(y: cardPresented ? 0 : -500)
        }
        .overlay(alignment: .bottomTrailing) {
            Button {
                show = false
            } label: {
                Text("OK")
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(RoundedRectangle(cornerRadius: 8).fill(.red))
                    .padding()
            }
            .opacity(showOKButton ? 1 : 0)
        }
        .overlay(alignment: .top) {
            HStack {
                Image(systemName: "star.fill")
                    .scaleEffect(showRank ? 1 : 0)
                    .animation(.interpolatingSpring(stiffness: 200, damping: 8), value: showRank)
                
                Image(systemName: "star.fill")
                    .scaleEffect(showRank ? 1 : 0)
                    .animation(.interpolatingSpring(stiffness: 170, damping: 8).delay(0.1), value: showRank)
                
                Image(systemName: "star.fill")
                    .scaleEffect(showRank ? 1 : 0)
                    .animation(.interpolatingSpring(stiffness: 170, damping: 8).delay(0.2), value: showRank)
                
                Image(systemName: "star.fill")
                    .scaleEffect(showRank ? 1 : 0)
                    .animation(.interpolatingSpring(stiffness: 170, damping: 8).delay(0.3), value: showRank)
                
                Image(systemName: "star.fill")
                    .scaleEffect(showRank ? 1 : 0)
                    .animation(.interpolatingSpring(stiffness: 170, damping: 8).delay(0.4), value: showRank)
            }
            .foregroundStyle(.linearGradient(colors: [.yellow, .white, .yellow, .yellow.opacity(0.3)], startPoint: .top, endPoint: .bottom))
            .font(.largeTitle)
            .padding(.top)
        }
        .onAppear {
            withAnimation(.easeOut(duration: 5)) {
                cardPresented = true
            } completion: {
                withAnimation {
                    showRank = true
                } completion: {
                    withAnimation {
                        showOKButton = true
                    }
                }
            }
        }
    }
}

#Preview {
    CardUnpackView(show: .constant(true))
}
