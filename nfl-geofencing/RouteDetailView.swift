import SwiftUI
import MapKit

struct RouteDetailView: View {
    @State private var destinationInputText = ""
    @State private var arrivalInputText = ""
    @State private var routes: [MKRoute] = []
    @State private var selectedRoute: MKRoute?
    @State private var dangerArea: [CircleArea] = []
    let dangerAreaRepository: DangerAreaRepository = JsonDangerAreaRepository()

    @State private var dangerPointCountList: [Int] = []
    @State private var rankList: [Int] = []
    @State private var scoreList: [Int] = []

    var body: some View {
        ZStack(alignment: .bottom) {
            Map {
                if let routePolyline = selectedRoute?.polyline as? MKPolyline {
                    MapPolyline(routePolyline)
                        .stroke(Color.blue, lineWidth: 8)
                }
                ForEach(dangerArea) { area in
                    MapCircle(
                        center: .init(latitude: area.latitude, longitude: area.longitude),
                        radius: area.radius
                    )
                    .foregroundStyle(.red.opacity(0.3))
                }
            }
            .onAppear {
                Task {
                    dangerArea = dangerAreaRepository.getAll()
                    await calculateRoute()
                    for route in routes {
                        dangerPointCountList.append(countRouteAvoidsArea(route: route))
                        self.rankList = convertPointToRank(originalArray: dangerPointCountList)
                        self.scoreList = assignScores(from: rankList)
                    }
                }
            }
            .sheet(isPresented: .constant(true)) {
                NavigationStack {
                    VStack {
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
                            ScrollView {
                                ZStack(alignment: .topLeading) {
                                    Rectangle()
                                        .fill(Color("BackgroundColor"))
                                    VStack {

                                        ForEach(routes.indices, id: \.self) { index in
                                            let route = routes[index]
                                            VStack(alignment: .leading, spacing: 0) {
                                                Text("\(Int(ceil(route.expectedTravelTime / 60))) min")
                                                    .font(.title3)
                                                    .bold()
                                                    .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
                                                HStack {
                                                    VStack(alignment: .leading, spacing: 13) {
                                                        HStack {
                                                            Text("\(Int(ceil(route.distance / 1609))) miles")
                                                            Spacer()
                                                            Text("\(countRouteAvoidsArea(route: route).description)")
                                                                .font(.caption2)
                                                            Text("SafetyRank:\(rankList[index])")
                                                                .font(.headline)
                                                        }
                                                        HStack(spacing: 8) {
                                                            Image(systemName: "football.fill")
                                                                .foregroundStyle(.blue)
                                                            Text("Expected points earned")
                                                            Text("\(scoreList[index])")
                                                                .font(.title3)
                                                                .bold()
                                                                .foregroundStyle(.blue)
                                                        }
                                                    }
                                                    Button{
                                                        self.selectedRoute = route
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
                                            //                                            .onAppear {
                                            //                                                dangerPointCountList.insert(countRouteAvoidsArea(route: route), at: 0)
                                            //                                            }
                                            Divider()
                                                .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
                                        }
                                    }
                                    .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                                }
                                .frame(width: 351, height: 300)
                                .cornerRadius(8)
                            }
                        }
                    }
                }
                .presentationDetents([.fraction(0.99), .height(600), .height(30)])
                .presentationBackgroundInteraction(.enabled)
                .interactiveDismissDisabled()
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
        request.requestsAlternateRoutes = true
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

    func countRouteAvoidsArea(route: MKRoute) -> Int {
        let routePolyline = route.polyline
        let pointCount = routePolyline.pointCount
        let points = routePolyline.points()
        var count = 0

        for i in 0..<pointCount {
            let coordinate = points[i].coordinate
            let location = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)

            func roundToThirdDecimalPlace(value: Double) -> Double {
                return (value * 1000).rounded() / 1000
            }

            func isCoordinateInRoundedRoute(route: CLLocationCoordinate2D, testCoordinate: CLLocationCoordinate2D) -> Bool {
                let roundedTestCoordinate = CLLocationCoordinate2D(
                    latitude: roundToThirdDecimalPlace(value: testCoordinate.latitude),
                    longitude: roundToThirdDecimalPlace(value: testCoordinate.longitude)
                )

                let roundedRouteCoordinate = CLLocationCoordinate2D(
                    latitude: roundToThirdDecimalPlace(value: route.latitude),
                    longitude: roundToThirdDecimalPlace(value: route.longitude)
                )

                if roundedRouteCoordinate.latitude == roundedTestCoordinate.latitude &&
                    roundedRouteCoordinate.longitude == roundedTestCoordinate.longitude {
                    return true
                }
                return false
            }

            for dangerPoint in dangerArea {
                let coordinate = CLLocationCoordinate2D(latitude: dangerPoint.latitude, longitude: dangerPoint.longitude)

                if isCoordinateInRoundedRoute(route: coordinate, testCoordinate: coordinate) {
                    count += 1
                }
            }
        }
        return count
    }

    func generateCoordinatePatterns(center: CLLocationCoordinate2D, latitudeRange: ClosedRange<Double>, longitudeRange: ClosedRange<Double>) -> [CLLocationCoordinate2D] {
        var patterns: [CLLocationCoordinate2D] = []

        let latStep = 0.0001
        let lonStep = 0.0001

        for lat in stride(from: latitudeRange.lowerBound, through: latitudeRange.upperBound, by: latStep) {
            for lon in stride(from: longitudeRange.lowerBound, through: longitudeRange.upperBound, by: lonStep) {
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                patterns.append(coordinate)
            }
        }

        return patterns
    }
}

func convertPointToRank(originalArray: [Int]) -> [Int] {
    let sortedArray = originalArray.sorted()
    var ranks = [Int](repeating: 0, count: originalArray.count)

    for (index, value) in originalArray.enumerated() {
        if let rank = sortedArray.firstIndex(of: value) {
            ranks[index] = rank + 1
        }
    }

    return ranks
}

func assignScores(from array: [Int]) -> [Int] {
    let count = array.count
    if count < 2 { return [] }

    var scores = [Int](repeating: 0, count: count)

    let indexedArray = array.enumerated().map { (index: $0.offset, value: $0.element) }

    let sortedArray = indexedArray.sorted { $0.value < $1.value }

    for (rank, element) in sortedArray.enumerated() {
        let score = 80 - ((70 * rank) / (count - 1))
        scores[element.index] = score
    }

    return scores
}


#Preview {
    RouteDetailView()
}
