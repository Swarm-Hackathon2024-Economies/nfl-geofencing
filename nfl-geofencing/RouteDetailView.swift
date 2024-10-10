import SwiftUI
import MapKit

struct RouteDetailView: View {
    @State private var destinationInputText = ""
    @State private var arrivalInputText = ""
    @State private var route: MKRoute?
    @State private var isShowingRoutes = false

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
            Map() {
                if let routePolyline = route?.polyline {
                    MapPolyline(routePolyline)
                        .stroke(.blue, lineWidth: 8)
                }
            }
            .onAppear {
                Task {
                    await calculateRoute()
                }
            }
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


    func calculateRoute() async {
        let sourceCoordinate = CLLocationCoordinate2D(
            latitude: 33.08575588060863,
            longitude: -96.83921907513722
        )
        let destinationCoordinate = CLLocationCoordinate2D(
            latitude: 32.74816795373609,
            longitude: -97.09333068671008
        )

        let sourcePlacemark = MKPlacemark(coordinate: sourceCoordinate)
        let destinationPlacemark = MKPlacemark(coordinate: destinationCoordinate)

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: sourcePlacemark)
        request.destination = MKMapItem(placemark: destinationPlacemark)
        request.transportType = .automobile
        if request.transportType == .transit {
            let directions = MKDirections(request: request)
            do {
                let etaResponse = try await directions.calculateETA()
                let etaSeconds = etaResponse.expectedTravelTime
                let etaMinutes = Int(etaSeconds / 60)
                print("ETA: \(etaMinutes)")
            } catch {
                print("ETA Error: \(error.localizedDescription)")
            }
        } else {
            do {
                let directions = MKDirections(request: request)
                let response = try await directions.calculate()
                let routes = response.routes
                route = routes.first
                print(routes)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}


#Preview {
    RouteDetailView()
}
