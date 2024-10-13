import SwiftUI

extension View {
    func scrollSpy(_ key: String, scrollOffset: Binding<CGFloat>) -> some View {
        modifier(ScrollSpy(key: key, scrollOffset: scrollOffset))
    }
}
