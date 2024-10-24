import SwiftUI

struct CustomHalfSheet<C: View>: ViewModifier {
    let modalContent: () -> C
    let offset: CGFloat = 540
    @Binding var modalOffset: CGFloat
    @State private var lastModalOffset: CGFloat = 540
    
    func body(content: Content) -> some View {
        ZStack(alignment: .topTrailing) {
            content
            VStack {
                Spacer()
                VStack {
                    Spacer()
                    
                    VStack {
                        Capsule()
                            .frame(width: 40, height: 5)
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .onTapGesture {
                                withAnimation {
                                    if modalOffset == offset {
                                        modalOffset = 40
                                    } else {
                                        modalOffset = offset
                                    }
                                    lastModalOffset = modalOffset
                                }
                            }
                        modalContent()
                    }
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, maxHeight: 600)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .offset(y: modalOffset)
                    .gesture(dragGesture)
                }
            }
        }
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                let newOffset = value.translation.height + lastModalOffset
                withAnimation {
                    if newOffset > offset {
                        modalOffset = offset
                    } else if newOffset < 40 {
                        modalOffset = 40
                    } else {
                        modalOffset = newOffset
                    }
                }
            }
            .onEnded { _ in
                withAnimation {
                    if modalOffset > lastModalOffset {
                        modalOffset = offset
                    } else {
                        modalOffset = 40
                    }
                }
                lastModalOffset = modalOffset
            }
    }
}
