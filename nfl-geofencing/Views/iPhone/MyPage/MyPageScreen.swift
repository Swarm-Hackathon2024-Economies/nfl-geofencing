import SwiftUI

struct MyPageScreen: View {
    var body: some View {
        ScrollView {
            Text("MyPage")
        }
        .mypageScreenToolbarItems()
        .mypageItemList()
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

struct MypageItemList: ViewModifier {
    let profileItems: [ProfileItem] = [
            ProfileItem(name: "MyProfile", imageName: "PeopleIcon"),
            ProfileItem(name: "Insurance class", imageName: "LikeIcon"),
        ]
    let externalLinkItems: [ProfileItem] = [
            ProfileItem(name: "TOYOTA", imageName: "TOYOTAIcon"),
            ProfileItem(name: "TOYOTA Account", imageName: "TOYOTAIcon"),
            ProfileItem(name: "NFL", imageName: "NFLIcon"),
            ProfileItem(name: "NFL Ticket", imageName: "NFLIcon"),
            ProfileItem(name: "NFL FLAG", imageName: "NFLFlagIcon"),
            ProfileItem(name: "FAQ & Contact Us", imageName: "QuestionIcon"),
        ]
    func body(content: Content) -> some View {
        VStack {
            Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
                    .padding(.horizontal)
            ForEach(profileItems, id: \.name) { item in
                            HStack {
                                Image(item.imageName)
                                Text(item.name)
                                Spacer()
                                Image("ArrowIcon")
                                    .padding()
                            }
                            .frame(height: 35)
                            .padding(.horizontal)
                            Rectangle()
                                .fill(Color.gray)
                                .frame(height: 1)
                                .padding(.horizontal)
                        }
            HStack {
            Text("External Link")
                    .font(.title2)
                    .foregroundStyle(.gray)
                    .bold()
                    .padding(.horizontal)
                Spacer()
            }
            .padding(.top,40)
            Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
                    .padding(.horizontal)
            ForEach(externalLinkItems, id: \.name) { item in
                            HStack {
                                Image(item.imageName)
                                Text(item.name)
                                Spacer()
                                Image("ArrowIcon")
                            }
                            .frame(height: 35)
                            .padding(.horizontal)
                            Rectangle()
                                .fill(Color.gray)
                                .frame(height: 1)
                                .padding(.horizontal)
                        }
        }
    }
}

extension View {
    func mypageScreenToolbarItems() -> some View {
        modifier(MypageScreenToolbarItems())
    }
    func mypageItemList() -> some View {
        modifier(MypageItemList())
    }
}

#Preview {
    MyPageScreen()
}

struct ProfileItem: Identifiable {
    let id = UUID() // 一意の識別子を生成
    let name: String // プロフィールの名前
    let imageName: String // 画像名
}
