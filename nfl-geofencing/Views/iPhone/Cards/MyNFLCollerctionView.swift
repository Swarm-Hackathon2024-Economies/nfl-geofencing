//
//  MyNFLCollerctionView.swift
//  nfl-geofencing
//
//  Created by takuya on 10/14/24.
//

import SwiftUI

struct MyNFLCollerctionView: View {
    var body: some View {
        HStack {
            Text("NFL Collections")
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                Text("23")
                    .font(.title2.bold())
                Text("/ 230")
            }
        }
        HStack {
            NavigationLink {
                PlayerCard()
                    .scaleEffect(0.9)
                    .cardsScreenToolbarItems()
            } label: {
                Image("MyNFLCollection1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
            }
            NavigationLink {
                PlayerCard()
                    .scaleEffect(0.9)
                    .cardsScreenToolbarItems()
            } label: {
                Image("MyNFLCollection2")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
            }
            NavigationLink {
                PlayerCard()
                    .scaleEffect(0.9)
                    .cardsScreenToolbarItems()
            } label: {
                Image("MyNFLCollection3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
            }
        }
    }
}

#Preview {
    MyNFLCollerctionView()
}
