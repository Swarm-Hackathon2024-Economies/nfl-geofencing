import SwiftUI

struct MyPageScreen: View {
    var body: some View {
        ScrollView {
            Text("MyPage")
        }
        .mypageScreenToolbarItems()
    }
}

struct MypageScreenToolbarItems: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("TitleIcon")
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 38) {
                        Image(systemName: "football.fill")
                            .font(.caption)
                            .foregroundStyle(.white)
                            .padding(4)
                            .background(Circle().fill(.red))
                        Text("2,234")
                            .font(.title2)
                            .bold()
                    }
                    .padding(.trailing)
                    .padding([.leading, .top, .bottom], 4)
                    .background(Capsule().stroke(.secondary))
                }
            }
    }
}

extension View {
    func mypageScreenToolbarItems() -> some View {
        modifier(MypageScreenToolbarItems())
    }
}

#Preview {
    MyPageScreen()
}
