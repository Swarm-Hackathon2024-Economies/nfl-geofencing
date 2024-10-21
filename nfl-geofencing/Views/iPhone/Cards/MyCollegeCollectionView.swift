//
//  MyCollegeCollectionView.swift
//  nfl-geofencing
//
//  Created by takuya on 10/14/24.
//

import SwiftUI

struct MyCollegeCollectionView: View {
    var body: some View {
        HStack {
            Text("College Collections")
                .font(.title2.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            Text("40")
                .font(.title2.bold())
            Text("/ 230")
        }
        HStack {
            NavigationLink {
                PlayerCard2(player: players[1])
                    .scaleEffect(0.9)
                    .cardsScreenToolbarItems()
            } label: {
                Image("MyCollegeCollection1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 140, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
            }
            NavigationLink {
                PlayerCard2(player: players[2])
                    .scaleEffect(0.9)
                    .cardsScreenToolbarItems()
            } label: {
                Image("MyCollegeCollection2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 140, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
            }
            NavigationLink {
                PlayerCard2(player: players[0])
                    .scaleEffect(0.9)
                    .cardsScreenToolbarItems()
            } label: {
                Image("MyCollegeCollection3")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 140, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
            }
        }
    }
}

#Preview {
    MyCollegeCollectionView()
}
