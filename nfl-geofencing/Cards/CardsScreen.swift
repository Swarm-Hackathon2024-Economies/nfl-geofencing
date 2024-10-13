import SwiftUI

struct CardsScreen: View {
    var body: some View {
        ScrollView{
            VStack (spacing:27) {
                HStack {
                    Image("CardsTitleIcon")
                    Spacer()
                    ZStack {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(width: 120, height: 30)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.red, lineWidth: 2)
                            )
                        
                        HStack {
                            Image("BallIcon")
                            Text("2,234")
                                .font(Font.title2)
                                .bold()
                        }
                    }
                    .cornerRadius(10)
                }
                HStack {
                    ZStack {
                        Rectangle()
                            .fill(.red)
                            .frame(width: 80, height: 30)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.red, lineWidth: 1)
                            )
                        HStack {
                            Image("WhiteBallIcon")
                            Text("Shop")
                                .foregroundStyle(.white)
                                .font(.body)
                        }
                    }
                    ZStack {
                        Rectangle()
                            .fill(.white)
                            .frame(width: 124, height: 30)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.red, lineWidth: 1)
                            )
                        Text("My Collection")
                            .foregroundStyle(.red)
                            .font(.body)
                    }
                    Spacer()
                }
                createNFLCollectionView(title: "NFL Collection", imageName: "CollectionPicture1")
                createNFLCollectionView(title: "College Collection", imageName: "CollectionPicture2")
                createNFLCollectionView(title: "Profile Parts", imageName: "CollectionPicture3")
                
            }
            .frame(width: 350)
        }
    }
}

#Preview {
    CardsScreen()
}
private func createNFLCollectionView(title: String, imageName: String) -> some View {
    VStack {
        HStack {
            Text(title)
                .font(.title2)
                .bold()
            Spacer()
        }
        ZStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(8)
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
            ZStack {
                Rectangle()
                    .fill(Color.white)
                    .opacity(0.8)
                    .frame(width: 143, height: 22)
                    .cornerRadius(4)
                Text("Oct.11 - Oct 24")
            }
            .offset(x: 95, y: 55)
        }
    }
}
