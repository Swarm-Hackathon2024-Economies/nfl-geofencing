//
//  MyCollectionView.swift
//  nfl-geofencing
//
//  Created by takuya on 10/14/24.
//

import SwiftUI

struct MyCollectionView: View {
    var body: some View {
        VStack {
            MyNFLCollerctionView()
            HStack {
                Spacer()
                Text("View all")
                    .font(.title3.bold())
                    .foregroundStyle(.red)
            }
            .padding(.bottom, 10)
            
            MyCollegeCollectionView()
            HStack {
                Spacer()
                Text("View all")
                    .font(.title3.bold())
                    .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    MyCollectionView()
}
