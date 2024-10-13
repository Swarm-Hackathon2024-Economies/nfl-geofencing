import SwiftUI

struct CardCollectionDetailView: View {
    @State private var showPurchaseDialog = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    HStack {
                        Text("NFL Collection")
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("Oct.11 - Oct.24")
                            .font(.subheadline)
                    }
                    cardCollection(title: "Series1", imageName: "NFLCollectionSeries1")
                    cardCollection(title: "Series2", imageName: "NFLCollectionSeries2")
                }
                .padding(.horizontal)
                .padding(.top, 16)
            }
            .zIndex(0)
            
            if showPurchaseDialog {
                Color.black.opacity(0.3).ignoresSafeArea()
                    .zIndex(1.0)
                purchaseDialog
                    .scaleEffect(showPurchaseDialog ? 1 : 0)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .zIndex(2.0)
            }
        }
        .cardsScreenToolbarItems()
    }
    
    func cardCollection(title: String, imageName: String) -> some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(alignment: .topLeading) {
                Text(title)
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Rectangle().fill(.red))
                    .padding(.top)
            }
            .overlay(alignment: .bottomTrailing) {
                Button {
                    showPurchaseDialog = true
                } label: {
                    HStack {
                        Text("Buy")
                            .font(.subheadline)
                        Image(systemName: "football.fill")
                            .font(.caption)
                            .foregroundStyle(.black)
                            .padding(4)
                            .background(Circle().fill(.white))
                        Text("300")
                            .font(.headline)
                    }
                    .foregroundStyle(.white)
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 8).fill(.black))
                    .padding(8)
                }
            }
    }
    
    var purchaseDialog: some View {
        VStack {
            Text("Do you want to\nopen a Series 1 card?")
                .multilineTextAlignment(.center)
                .font(.title3)
                .fontWeight(.heavy)
            
            HStack {
                Image(systemName: "football.fill")
                    .font(.caption)
                    .foregroundStyle(.white)
                    .padding(4)
                    .background(Circle().fill(.red))
                Text("300").font(.body.bold())
            }
            
            Button {
                withAnimation {
                    showPurchaseDialog = false
                }
            } label: {
                Text("Unpack")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 8).fill(.red))
            }
            
            Button {
                withAnimation {
                    showPurchaseDialog = false
                }
            } label: {
                Text("Cancel")
                    .fontWeight(.bold)
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity)
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(.red))
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(.white))
        .padding()
    }
}

#Preview {
    NavigationStack {
        CardCollectionDetailView()
    }
}
