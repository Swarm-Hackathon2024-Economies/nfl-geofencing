import SwiftUI
import MapKit

struct RouteDetailView: View {
    @State private var destinationInputText = ""
    @State private var arrivalInputText = ""

    var body: some View {
        VStack {
            HStack{
                Text("出発地")
                TextField("出発地", text:$destinationInputText)
            }
            HStack{
                Text("到着地")
                TextField("到着地", text:$arrivalInputText)
            }
            Map()
                .frame(width: 300, height:200)
            HStack{
                Text("ルート1")
                Text("5点獲得できそうだよ")
            }
            HStack{
                Text("ルート2")
                Text("2点獲得できそうだよ")
            }
            Button("このルートで出発"){}
                .frame(minWidth: 300)
                .background(Color.cyan)
        }
    }
}


#Preview {
    RouteDetailView()
}
