import SwiftUI

extension View {
    func scrollSpy(_ key: String, scrollOffset: Binding<CGFloat>) -> some View {
        modifier(ScrollSpy(key: key, scrollOffset: scrollOffset))
    }
    
    func customHalfSheet(offset: Binding<CGFloat>, _ modalContent: @escaping () -> some View) -> some View {
        modifier(CustomHalfSheet(modalContent: modalContent, modalOffset: offset))
    }
}
