//
//  DestinationRegistorView.swift
//  nfl-geofencing
//
//  Created by 伊佐治恵介 on 2024/10/08.
//

import SwiftUI
import MapKit

struct DestinationRegistorView: View {
    let onSubmit: () -> Void
    @State private var destinationInputText = ""
    @State private var arrivalInputText = ""

    var body: some View {
        VStack{
            Text("行先登録")
            HStack{
                Text("出発地")
                TextField("出発地", text:$destinationInputText)
            }
            HStack{
                Text("到着地")
                TextField("到着地", text:$arrivalInputText)
            }
            Map()
                .frame(width: 300, height:400)
            Button("登録"){
                onSubmit()
            }
        }
    }
}

#Preview {
    DestinationRegistorView(onSubmit: {})
}
