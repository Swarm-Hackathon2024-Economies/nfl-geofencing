import SwiftUI

struct PlayerCard: View {
    @State var translation: CGSize = .zero
    @State var isDragging = false
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                translation = value.translation
                isDragging = true
            }
            .onEnded { value in
                withAnimation {
                    translation = .zero
                    isDragging = false
                }
            }
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            Image("Background 1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 600)
                .overlay {
                    Image("Logo 2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 400)
                        .offset(x: translation.width / 10, y: translation.height / 20)
                    Image("Logo 3")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 392, height: 600)
                        .blendMode(.overlay)
                        .offset(x: translation.width / 15, y: translation.height / 30)
                }
                .overlay(gloss("Gloss 2").blendMode(.luminosity))
                .overlay {
                    Text("Mitchell Wilcox")
                        .font(.system(size: 90, weight: .heavy))
                        .fontWidth(.compressed).foregroundStyle(.white.opacity(0.5))
                        .rotationEffect(.degrees(90))
                        .offset(x: 140)
                    Image("Player 1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .offset(x: translation.width / 8, y: translation.height / 15)
                }
                .overlay(gloss("Gloss 1").blendMode(.softLight))
                .overlay(gloss("Gloss 2").blendMode(.overlay))
                .overlay(
                    LinearGradient(
                        colors: [.clear, .white.opacity(0.5), .clear],
                        startPoint: .topLeading,
                        endPoint: calcEndPoint(intercept: 1)
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .strokeBorder(
                            .linearGradient(
                                colors: [.clear, .white.opacity(0.75), .clear, .white.opacity(0.75), .clear],
                                startPoint: .topLeading,
                                endPoint: calcEndPoint(intercept: 0.5)
                            )
                        )
                )
                .overlay(
                    LinearGradient(
                        colors: [Color(#colorLiteral(red: 0.08488377256, green: 0.3612681958, blue: 0.9763135314, alpha: 0.5)), Color(#colorLiteral(red: 0.6534066752, green: 0.2242571414, blue: 0.9763135314, alpha: 0.5))],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .blendMode(.overlay)
                )
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .scaleEffect(0.9)
                .rotation3DEffect(.degrees(isDragging ? 10 : 0), axis: (x: -translation.height, y: translation.width, z: 0))
                .gesture(drag)
        }
    }
    
    func gloss(_ imageName: String) -> some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .mask(
                LinearGradient(
                    colors: [.clear, .white, .clear, .white, .clear, .white, .clear],
                    startPoint: .topLeading,
                    endPoint: UnitPoint(x: abs(translation.height) / 100 + 1, y: abs(translation.height) / 100 + 1)
                )
            )
    }
    
    func calcEndPoint(intercept: CGFloat) -> UnitPoint {
        UnitPoint(x: abs(translation.height) / 100 + intercept, y: abs(translation.height) / 100 + intercept)
    }
}

#Preview {
    PlayerCard()
}
