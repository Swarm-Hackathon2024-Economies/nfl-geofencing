import SwiftUI

struct ToyotaNaviSidebar: ViewModifier {
    enum Item: String {
        case map = "location.fill"
        case music = "music.note"
        case phone = "phone.fill"
        case car = "car.fill"
        case setting = "gearshape.fill"
    }
    
    @Binding var selection: Item
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                sidebar(width: geometry.size.width / 12)
                content
            }
        }
        .ignoresSafeArea()
    }
    
    private func sidebar(width: CGFloat) -> some View {
        Rectangle()
            .fill(.white)
            .frame(width: width)
            .overlay {
                VStack {
                    Spacer()
                    sidebarItem(.map)
                    Spacer()
                    sidebarItem(.music)
                    Spacer()
                    sidebarItem(.phone)
                    Spacer()
                    sidebarItem(.car)
                    Spacer()
                    sidebarItem(.setting)
                    Spacer()
                }
            }
    }
    
    private func sidebarItem(_ item: Item) -> some View {
        Button {
            selection = item
        } label: {
            Image(systemName: item.rawValue)
                .font(.title2)
                .padding()
                .background {
                    if selection == item {
                        Circle().fill(.blue.opacity(0.1))
                    }
                }
        }
    }
}

extension View {
    func toyotaNaviSidebar(selection: Binding<ToyotaNaviSidebar.Item>) -> some View {
        modifier(ToyotaNaviSidebar(selection: selection))
    }
}

#Preview {
    Rectangle().fill(.gray)
        .toyotaNaviSidebar(selection: .constant(.map))
}
