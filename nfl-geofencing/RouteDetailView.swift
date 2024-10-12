import SwiftUI
import MapKit

struct RouteDetailView: View {
    @State private var destinationInputText = ""
    @State private var arrivalInputText = ""
    @State private var routes: [MKRoute]?
    @State private var modalOffset: CGFloat = UIScreen.main.bounds.height - 255
    @State private var lastModalOffset: CGFloat = UIScreen.main.bounds.height - 255
    @State private var selectedRoute: MKRoute?


    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Map {
                    if let routePolyline = selectedRoute?.polyline as? MKPolyline {
                        MapPolyline(routePolyline)
                            .stroke(Color.blue, lineWidth: 8)
                    }
                }
                .onAppear {
                    Task {
                        await calculateRoute()
                    }
                }
                .onChange(of: selectedRoute) {
                    Task {
                        guard let tmp = selectedRoute else {return}
                        await checkRouteAvoidsArea(route: tmp)
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
                                    if modalOffset == UIScreen.main.bounds.height - 685 {
                                        modalOffset = UIScreen.main.bounds.height - 255
                                    } else {
                                        modalOffset = UIScreen.main.bounds.height - 685
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
                        .padding(EdgeInsets(
                            top: 0, leading: 22, bottom: 0, trailing: 0
                        ))
                        VStack {
                            ZStack {
                                Rectangle()
                                    .fill(Color("BackgroundColor"))
                                VStack(alignment: .leading) {
                                    HStack{
                                        Image(systemName: "location.circle.fill")
                                            .resizable()
                                            .frame(width: 22, height: 22)
                                            .foregroundStyle(.red)
                                            .padding(EdgeInsets(
                                                top: 10, leading: 18, bottom: 10, trailing: 18
                                            ))
                                        VStack {
                                            HStack {
                                                TextField("Toyota Motor North America, Inc.", text:$destinationInputText)
                                                Image(systemName: "line.3.horizontal")
                                                    .foregroundStyle(.gray)
                                            }
                                            .frame(height: 22)
                                            Divider()
                                        }
                                        .padding(EdgeInsets(
                                            top: 0, leading: 0, bottom: 0, trailing: 20
                                        ))
                                    }
                                    .padding(EdgeInsets(
                                        top: 15, leading: 0, bottom: 0, trailing: 0
                                    ))
                                    Image("dots_vertical")
                                        .padding(EdgeInsets(
                                            top: 0, leading: 25, bottom: 0, trailing: 0
                                        ))
                                    HStack{
                                        Image(systemName: "mappin.circle.fill")
                                            .resizable()
                                            .frame(width: 22, height: 22)
                                            .foregroundStyle(.red)
                                            .padding(EdgeInsets(
                                                top: 10, leading: 18, bottom: 10, trailing: 18
                                            ))
                                        VStack {
                                            HStack {
                                                TextField("AT&T Stadium", text:$arrivalInputText)
                                                Image(systemName: "line.3.horizontal")
                                                    .foregroundStyle(.gray)
                                            }
                                            .frame(height: 22)
                                            Divider()
                                        }
                                        .padding(EdgeInsets(
                                            top: 0, leading: 0, bottom: 0, trailing: 20
                                        ))
                                    }
                                    Image("dots_vertical")
                                        .padding(EdgeInsets(
                                            top: 0, leading: 25, bottom: 0, trailing: 0
                                        ))
                                    HStack{
                                        Image(systemName: "plus.circle.fill")
                                            .resizable()
                                            .frame(width: 22, height: 22)
                                            .foregroundStyle(.red)
                                            .padding(EdgeInsets(
                                                top: 10, leading: 18, bottom: 10, trailing: 18
                                            ))
                                        TextField("Add waypoint", text:$arrivalInputText)
                                    }
                                }
                            }
                            .frame(width: 351, height: 230)
                            .cornerRadius(8)
                            ZStack(alignment: .topLeading) {
                                Rectangle()
                                    .fill(Color("BackgroundColor"))
                                VStack {
                                    if let unwrappedRoutes = routes {
                                        ForEach(unwrappedRoutes, id: \.self) { route in
                                            VStack(alignment: .leading, spacing: 0) {
                                                HStack {
                                                    Text("\(Int(ceil(route.expectedTravelTime / 60))) min")
                                                        .font(.title3)
                                                        .bold()
                                                }
                                                HStack {
                                                    VStack(alignment: .leading, spacing: 13) {
                                                        HStack {
                                                            Text("\(Int(ceil(route.distance / 1.609))) miles")
                                                            Spacer()
                                                        }
                                                        HStack(spacing: 8) {
                                                            Image(systemName: "football.fill")
                                                                .foregroundStyle(.blue)
                                                            Text("Expected points earned")
                                                            Text("50")
                                                                .font(.title3)
                                                                .bold()
                                                                .foregroundStyle(.blue)
                                                        }
                                                    }
                                                    Button{
                                                        self.selectedRoute = route
                                                        withAnimation{
                                                            self.modalOffset = UIScreen.main.bounds.height - 255
                                                        }

                                                    } label: {
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
                                        }
                                    }
                                    Divider()
                                }
                                .padding(15)
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
                                if newOffset < UIScreen.main.bounds.height - 685 {
                                    modalOffset = UIScreen.main.bounds.height - 685
                                } else if newOffset > UIScreen.main.bounds.height - 255 {
                                    modalOffset = UIScreen.main.bounds.height - 255
                                } else {
                                    modalOffset = newOffset
                                }
                            }
                            .onEnded { _ in
                                withAnimation {
                                    if modalOffset < lastModalOffset {
                                        modalOffset = UIScreen.main.bounds.height - 685
                                    } else {
                                        modalOffset = UIScreen.main.bounds.height - 255
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
            longitude: -96.83922557513722
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
        } catch {
            print(error.localizedDescription)
        }
    }

    func checkRouteAvoidsArea(route: MKRoute) -> Bool {
        let routePolyline = route.polyline
        let pointCount = routePolyline.pointCount
        let points = routePolyline.points()

        for i in 0..<pointCount {
            print("\(i)周目")
            let coordinate = points[i].coordinate
            let location = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)

            let testCoordinate = CLLocationCoordinate2D(latitude: 32.7488, longitude: -97.0937)

            func roundToThirdDecimalPlace(value: Double) -> Double {
                return (value * 1000).rounded() / 1000
            }

            // 指定した座標が四捨五入した経路の座標に含まれているか確認する関数
            func isCoordinateInRoundedRoute(route: CLLocationCoordinate2D, testCoordinate: CLLocationCoordinate2D) -> Bool {
                let roundedTestCoordinate = CLLocationCoordinate2D(
                    latitude: roundToThirdDecimalPlace(value: testCoordinate.latitude),
                    longitude: roundToThirdDecimalPlace(value: testCoordinate.longitude)
                )

                let roundedRouteCoordinate = CLLocationCoordinate2D(
                    latitude: roundToThirdDecimalPlace(value: route.latitude),
                    longitude: roundToThirdDecimalPlace(value: route.longitude)
                )

                print("\(roundedTestCoordinate)")
                print("\(roundedRouteCoordinate)")

                // 一致を確認
                if roundedRouteCoordinate.latitude == roundedTestCoordinate.latitude &&
                    roundedRouteCoordinate.longitude == roundedTestCoordinate.longitude {
                    return true // 一致する座標が見つかった
                }
                return false // 一致する座標が見つからなかった
            }

            if isCoordinateInRoundedRoute(route: coordinate, testCoordinate: testCoordinate) {
                print("指定した座標は四捨五入した経路の座標に含まれています。")
            } else {
                print("指定した座標は四捨五入した経路の座標に含まれていません。")
            }
        }
        return true  // エリアに触れていない
    }

    func generateCoordinatePatterns(center: CLLocationCoordinate2D, latitudeRange: ClosedRange<Double>, longitudeRange: ClosedRange<Double>) -> [CLLocationCoordinate2D] {
        var patterns: [CLLocationCoordinate2D] = []

        // 緯度と経度を小数点第4位までの範囲で生成
        let latStep = 0.0001
        let lonStep = 0.0001

        // 緯度の範囲をループ
        for lat in stride(from: latitudeRange.lowerBound, through: latitudeRange.upperBound, by: latStep) {
            // 経度の範囲をループ
            for lon in stride(from: longitudeRange.lowerBound, through: longitudeRange.upperBound, by: lonStep) {
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                patterns.append(coordinate)
            }
        }

        return patterns
    }
}

#Preview {
    RouteDetailView()
}
