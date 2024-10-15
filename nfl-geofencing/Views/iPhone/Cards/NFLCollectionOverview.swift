import SwiftUI

struct NFLCollectionOverview: View {
    let title: String
    let imageName: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                .overlay(alignment: .bottomTrailing) {
                    Text("Oct.11 - Oct 24")
                        .font(.headline)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.white)
                                .opacity(0.8)
                        )
                        .padding(8)
                }
        }
    }
}

#Preview {
    NFLCollectionOverview(title: "NFL Collection", imageName: "CollectionPicture1")
}
