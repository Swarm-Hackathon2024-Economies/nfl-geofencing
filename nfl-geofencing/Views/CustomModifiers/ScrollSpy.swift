import SwiftUI

struct ScrollSpy: ViewModifier {
    struct ScrollOffsetPreferenceKey: PreferenceKey {
        static var defaultValue: CGPoint = .zero
        
        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
    }

    let key: String
    @Binding var scrollOffset: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(GeometryReader { geometry in
                Color.clear
                    .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named(key)).origin)
            })
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                self.scrollOffset = value.y
            }
    }
}
