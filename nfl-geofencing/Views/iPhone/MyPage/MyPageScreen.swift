import SwiftUI

struct MyPageScreen: View {
    let profileItems: [ProfileItem] = [
        ProfileItem(name: "MyProfile", imageName: "PeopleIcon", link: ""),
        ProfileItem(name: "Insurance class", imageName: "LikeIcon", link: ""),
    ]
    let externalLinkItems: [ProfileItem] = [
        ProfileItem(name: "TOYOTA", imageName: "TOYOTAIcon", link: "https://global.toyota/jp/"),
        ProfileItem(name: "TOYOTA Account", imageName: "TOYOTAIcon", link: "https://id.toyota/"),
        ProfileItem(name: "NFL", imageName: "NFLIcon", link: "https://www.nfl.com/"),
        ProfileItem(name: "NFL Ticket", imageName: "NFLIcon", link: "https://www.ticketmaster.com/"),
        ProfileItem(name: "NFL FLAG", imageName: "NFLFlagIcon", link: "https://nflflag.com/"),
        ProfileItem(name: "FAQ & Contact Us", imageName: "QuestionIcon", link: ""),
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 1)
                    ForEach(profileItems, id: \.name) { item in
                        HStack {
                            Image(item.imageName)
                            Text(item.name)
                            Spacer()
                            Image("ArrowIcon")
                                .padding()
                        }
                        .frame(height: 35)
                        Rectangle()
                            .fill(Color.gray)
                            .frame(height: 1)
                    }
                    HStack {
                        Text("External Link")
                            .font(.title2)
                            .foregroundStyle(.gray)
                            .bold()
                        Spacer()
                    }
                    .padding(.top,40)
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 1)
                    ForEach(externalLinkItems, id: \.name) { item in
                        HStack {
                            Image(item.imageName)
                            Text(item.name)
                            Spacer()
                            Image("ArrowIcon")
                        }
                        .frame(height: 35)
                        .background(.white)
                        .onTapGesture {
                            if let url = URL(string: item.link) {
                                UIApplication.shared.open(url)
                            }
                        }
                        Rectangle()
                            .fill(Color.gray)
                            .frame(height: 1)
                    }
                }
                .padding()
            }
            .mypageScreenToolbarItems()
        }
    }
}

struct MypageScreenToolbarItems: ViewModifier {
    @EnvironmentObject var scoreManager: ScoreManager

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image("MyPageTitleIcon")
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 38) {
                        Image(systemName: "football.fill")
                            .font(.caption)
                            .foregroundStyle(.white)
                            .padding(4)
                            .background(Circle().fill(.red))
                        Text("\(scoreManager.score)")
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
    MyPageScreen().environmentObject(ScoreManager())
}

struct ProfileItem: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let link: String
}
