import SwiftUI
import MapKit

struct RouteDetailView: View {
    @State private var destinationInputText = ""
    @State private var arrivalInputText = ""
    @State private var routes: [MKRoute]?
    @State private var modalOffset: CGFloat = UIScreen.main.bounds.height - 125
    @State private var lastModalOffset: CGFloat = UIScreen.main.bounds.height - 125
    @State var isOverlayVisible: Bool = true


    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Map {
                    if let unwrappedRoutes = routes {
                        ForEach(unwrappedRoutes, id: \.self) { route in
                            if let routePolyline = route.polyline as? MKPolyline {
                                MapPolyline(routePolyline)
                                    .stroke(Color.blue, lineWidth: 8)
                            }
                        }
                    }
                }
                .onAppear {
                    Task {
                        await calculateRoute()
                    }
                }
            }
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    Spacer()
                    VStack {
                        Capsule()
                            .frame(width: 40, height: 5)
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .onTapGesture {
                                withAnimation {
                                    if modalOffset == UIScreen.main.bounds.height - 555 {
                                        modalOffset = UIScreen.main.bounds.height - 125
                                    } else {
                                        modalOffset = UIScreen.main.bounds.height - 555
                                    }
                                    lastModalOffset = modalOffset
                                }
                            }
                        HStack(spacing:0) {
                            Image(systemName: "book.pages")
                            Text("Playbook")
                                .font(.title2)
                                .bold()
                            Spacer()
                        }
                        VStack {
                            ZStack {
                                Rectangle()
                                    .fill(Color("BackgroundColor"))
                                VStack {
                                    HStack{
                                        Text("出発地")
                                        TextField("出発地", text:$destinationInputText)
                                    }
                                    HStack{
                                        Text("到着地")
                                        TextField("到着地", text:$arrivalInputText)
                                    }
                                }
                            }
                            .frame(width: 351, height: 160)
                            .cornerRadius(8)
                            ZStack {
                                Rectangle()
                                    .fill(Color("BackgroundColor"))
                                VStack {
                                    if let unwrappedRoutes = routes {
                                        ForEach(unwrappedRoutes, id: \.self) { route in
                                            VStack(alignment: .leading) {
                                                HStack {
                                                    Text("\(Int(ceil(route.expectedTravelTime / 60))) min")
                                                        .font(.title3)
                                                        .bold()
                                                    Spacer()
                                                }
                                                HStack {
                                                    VStack {
                                                        HStack {
                                                            Text("\(Int(ceil(route.distance / 1.609))) miles")
                                                            Spacer()
                                                        }
//                                                        HStack {
//                                                            Image(systemName: "football.fill")
//                                                            Text("Expected points earned")
//                                                            Text(50)
//                                                                .font(.title3)
//                                                                .foregroundStyle(.blue)
//                                                        }
                                                    }
                                                    Button{} label: {
                                                        ZStack {

                                                            Rectangle()
                                                                .frame(width: 62, height: 62)
                                                                .foregroundStyle(.blue)
                                                                .cornerRadius(8)
                                                            Text("GO")
                                                                .foregroundStyle(.white)
                                                                .font(.title2)
                                                                .bold()
                                                        }
                                                    }
                                                    .frame(width: 62, height: 62)

                                                }
                                            }
                                            .frame(height: 90)
                                            .padding(15)
                                        }
                                    }
                                    Divider()
                                }
                            }
                            .frame(width: 351, height: 300)
                            .cornerRadius(8)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 615)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .offset(y: modalOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newOffset = value.translation.height + lastModalOffset
                                if newOffset < UIScreen.main.bounds.height - 555 {
                                    modalOffset = UIScreen.main.bounds.height - 555
                                } else if newOffset > UIScreen.main.bounds.height - 125 {
                                    modalOffset = UIScreen.main.bounds.height - 125
                                } else {
                                    modalOffset = newOffset
                                }
                            }
                            .onEnded { _ in
                                withAnimation {
                                    if modalOffset < lastModalOffset {
                                        modalOffset = UIScreen.main.bounds.height - 555
                                    } else {
                                        modalOffset = UIScreen.main.bounds.height - 125
                                    }
                                }
                                lastModalOffset = modalOffset
                            }
                    )
                }
            }
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

        do {
            let directions = MKDirections(request: request)
            let response = try await directions.calculate()
            let routes = response.routes
            self.routes = routes
            print(routes)
        } catch {
            print(error.localizedDescription)
        }
    }

}

#Preview {
    RouteDetailView()
}
