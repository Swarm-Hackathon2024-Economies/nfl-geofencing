import SwiftUI

struct CardUnpackView2: View {
    @State private  var cardPresented = false
    let animationPhases: [AnimationPhase] = [
        .init(offsetX: -120, offsetY: -150, scale: 0.2),
        .init(offsetX: 120, offsetY: -50, scale: 0.5),
        .init(offsetX: 0, offsetY: 0, scale: 1),
    ]
    
    struct AnimationPhase: Equatable {
        let offsetX: CGFloat
        let offsetY: CGFloat
        let scale: CGFloat
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            PlayerCard()
                .phaseAnimator(animationPhases) { content, phase in
                    content
                        .scaleEffect(phase.scale)
                        .offset(x: phase.offsetX, y: phase.offsetY)
                } animation: { _ in .spring }
                
        }
        .onAppear {
            withAnimation(.easeOut(duration: 5)) {
                cardPresented = true
            }
        }
    }
}

#Preview {
    CardUnpackView2()
}
