import SwiftUI

struct PlayerCard2: View {
    let player: Player
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
        Image("\(player.imagePrefix)_5")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: 600)
            .overlay {
                Image("\(player.imagePrefix)_2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(x: translation.width / 15, y: translation.height / 30)
                Image("\(player.imagePrefix)_1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(x: translation.width / 8, y: translation.height / 15)
            }
            .overlay(gloss("\(player.imagePrefix)_3").blendMode(player.grossBlendMode1))
            .overlay(gloss("\(player.imagePrefix)_4").blendMode(player.grossBlendMode2))
            .overlay(
                LinearGradient(
                    colors: [.clear, .white.opacity(0.5), .clear],
                    startPoint: .topLeading,
                    endPoint: calcEndPoint(intercept: 1)
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
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
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .rotation3DEffect(.degrees(isDragging ? 10 : 0), axis: (x: -translation.height, y: translation.width, z: 0))
            .gesture(drag)
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

struct Player: Identifiable {
    var id: String {
        imagePrefix
    }
    let imagePrefix: String
    let grossBlendMode1: BlendMode
    let grossBlendMode2: BlendMode
}

struct CardGallary: View {
    
    var body: some View {
        TabView {
            ForEach(players) { player in
                ZStack {
                    Color.black
                    PlayerCard2(player: player)
                        .scaleEffect(0.9)
                }
            }
        }
        .tabViewStyle(.page)
    }
}

#Preview {
    CardGallary()
}
