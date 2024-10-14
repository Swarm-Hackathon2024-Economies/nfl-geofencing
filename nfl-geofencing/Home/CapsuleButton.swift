import SwiftUI

struct CapsuleButton: View {
    enum Style {
        case outlined
        case filled
    }
    let text: String
    let style: Style
    
    init(_ text: String, style: Style = .outlined) {
        self.text = text
        self.style = style
    }
    
    var body: some View {
        Text(text)
            .foregroundStyle(style == .filled ? .white : .red)
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(.red)
                    .opacity(style == .filled ? 1 : 0)
                    .overlay {
                        Capsule().stroke(.red).opacity(style == .outlined ? 1 : 0)
                    }
            )
    }
}

#Preview {
    CapsuleButton("Button")
}
