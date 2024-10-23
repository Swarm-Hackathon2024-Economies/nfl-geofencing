import SwiftUI
import MapKit

struct RouteDetailView: View {
    @State private var destinationInputText = "Toyota Motor North America, Inc."
    @State private var arrivalInputText = "AT&T S"
    @State private var addInputText = "Add waypoint"
    @State private var routes: [MKRoute] = []
    @State private var selectedRoute: MKRoute?
    @State private var dangerArea: [CircleArea] = []
    let dangerAreaRepository: DangerAreaRepository = JsonDangerAreaRepository()

    @State private var dangerPointCountList: [Int] = []
    @State private var rankList: [Int] = []
    @State private var scoreList: [Int] = []
    @State private var fasterRouteList: [Double] = []

    @ObservedObject var mcSessionManager = MCSessionManager()

    @State private var sourceCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(
        latitude: 33.08575588060863,
        longitude: -96.83922557513722
    )
    @State private var destinationCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(
        latitude: 32.74816795373609,
        longitude: -97.09333068671008
    )
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 32.7767, longitude: -96.7970),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )

    let offset: CGFloat = 540
    @State private var modalOffset: CGFloat = 540
    @State private var lastModalOffset: CGFloat = 540

    @State private var childHeight: CGFloat = .zero
    @State private var isNight: Bool = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                Map {
                    ForEach(routes, id: \.self) { route in
                        MapPolyline(route)
                            .stroke(Color.gray, lineWidth: 8)
                    }
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
                .preferredColorScheme(isNight ? .dark : .light)
            }
            .onChange(of: isNight) {
                Task {
                    routes = []
                    dangerArea = dangerAreaRepository.get(by: .spring, isNight: isNight)
                    selectedRoute = nil
                    await calculateRoute(source: self.sourceCoordinate, destination: self.destinationCoordinate)
                    dangerPointCountList = []
                    for route in routes {
                        dangerPointCountList.append(countRouteAvoidsArea(route: route))
                        self.rankList = convertPointToRank(originalArray: dangerPointCountList)
                        self.scoreList = assignScores(from: rankList)
                        self.fasterRouteList.append(route.expectedTravelTime)
                    }
                    self.fasterRouteList.sort()
                }
            }
            Button(action: {
                Task {
                    routes = []
                    await calculateRoute(source: self.sourceCoordinate, destination: self.destinationCoordinate)
                }
                isNight = !isNight
            }) {
                if isNight {
                    Image(systemName: "moon.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .shadow(radius: 2)
                } else {
                    Image(systemName: "sun.max.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.blue)
                        .shadow(radius: 2)
                }
            }
            .disabled(routes.isEmpty)
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 16))
            VStack {
                Spacer()
                VStack {
                    Spacer()
                    VStack {
                        Capsule()
                            .frame(width: 40, height: 5)
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .onTapGesture {
                                withAnimation {
                                    if modalOffset == offset {
                                        modalOffset = 40
                                    } else {
                                        modalOffset = offset
                                    }
                                    lastModalOffset = modalOffset
                                }
                            }
                        NavigationStack {
                            VStack {
                                HStack(spacing:0) {
                                    Image(systemName: "book.pages")
                                    Text("Playbook")
                                        .font(.title2)
                                        .bold()
                                    Spacer()
                                    if let _ = mcSessionManager.connectedPeerID {
                                        Image(systemName: "checkmark.circle.fill")
                                        Text("Connected")
                                    } else {
                                        Image(systemName: "xmark.circle.fill")
                                        Text("No connection")
                                    }
                                }
                                .foregroundStyle(.black)
                                .padding(EdgeInsets(
                                    top: 0, leading: 22, bottom: 0, trailing: 22
                                ))
                                VStack {
                                    ScrollView {
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
                                                    TextField("Add waypoint", text: $addInputText)
                                                        .foregroundStyle(.blue)
                                                    Button {
                                                        Task {
                                                            routes = []
                                                            dangerArea = dangerAreaRepository.get(by: .spring, isNight: isNight)
                                                            await calculateRoute(source: self.sourceCoordinate, destination: self.destinationCoordinate)
                                                            dangerPointCountList = []
                                                            for route in routes {
                                                                dangerPointCountList.append(countRouteAvoidsArea(route: route))
                                                                self.rankList = convertPointToRank(originalArray: dangerPointCountList)
                                                                self.scoreList = assignScores(from: rankList)
                                                                self.fasterRouteList.append(route.expectedTravelTime)
                                                            }
                                                            self.fasterRouteList.sort()
                                                        }
                                                    } label: {
                                                        Text("Search")
                                                    }
                                                }
                                            }
                                        }
                                        .frame(width: 351, height: 230)
                                        .cornerRadius(8)
                                        ZStack(alignment: .topLeading) {
                                            Rectangle()
                                                .fill(Color("BackgroundColor"))
                                            if routes.count == 0 {
                                                Text("Now Loading...(いい感じのGIF当てたい!)")
                                            } else {
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
                                                                    }
                                                                    HStack(spacing: 8) {
                                                                        if rankList[index] != rankList.last {
                                                                            Image(systemName: "heart.fill")
                                                                                .foregroundStyle(.red)
                                                                        }
                                                                        if routes[index].expectedTravelTime != fasterRouteList.last {
                                                                            Image(systemName: "clock.fill")
                                                                                .foregroundStyle(.green)
                                                                        }
                                                                        Spacer()
                                                                        Text("SafetyRank:\(rankList[index])")
                                                                            .font(.headline)
                                                                            .padding(.trailing, 8)
                                                                    }
                                                                }
                                                                Button {
                                                                    self.selectedRoute = route
                                                                    withAnimation {
                                                                        modalOffset = offset
                                                                    }
                                                                    guard let data = try? JSONEncoder().encode(true) else { return }
                                                                    mcSessionManager.sendDataToAllPeers(data: data)
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
                                                        Divider()
                                                            .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 0))
                                                    }
                                                }
                                                .padding(EdgeInsets(top: 10, leading: 15, bottom: 0, trailing: 15))
                                            }
                                        }
                                        .frame(width: 351, height: 400)
                                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                                        .cornerRadius(8)
                                    }
                                }
                            }
                            .background(Color.white)
                        }
                    }
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, maxHeight: 600)
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(radius: 10)
                    .offset(y: modalOffset)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let newOffset = value.translation.height + lastModalOffset
                                withAnimation {
                                    if newOffset > offset {
                                        modalOffset = offset
                                    } else if newOffset < 40 {
                                        modalOffset = 40
                                    } else {
                                        modalOffset = newOffset
                                    }
                                }
                            }
                            .onEnded { _ in
                                withAnimation {
                                    if modalOffset > lastModalOffset {
                                        modalOffset = offset
                                    } else {
                                        modalOffset = 40
                                    }
                                }
                                lastModalOffset = modalOffset
                            }
                    )
                }
            }
        }
        .onAppear {
            mcSessionManager.startBrowsing()
        }
        .onDisappear {
            self.isNight = false
        }
    }

    func calculateRoute(source: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) async {
        let sourcePlacemark = MKPlacemark(coordinate: source)
        let destinationPlacemark = MKPlacemark(coordinate: destination)

        let request = MKDirections.Request()
        request.source = Place.tmna
        request.destination = Place.atAndTStadium

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

    func countRouteAvoidsArea(route: MKRoute) -> Int {
        let routePolyline = route.polyline
        let pointCount = routePolyline.pointCount
        let points = routePolyline.points()
        var count = 0

        for i in 0..<pointCount {
            let coordinate = points[i].coordinate

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

        let step = 0.0001

        for lat in stride(from: latitudeRange.lowerBound, through: latitudeRange.upperBound, by: step) {
            for lon in stride(from: longitudeRange.lowerBound, through: longitudeRange.upperBound, by: step) {
                let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                patterns.append(coordinate)
            }
        }

        return patterns
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
    
    func convertExpectedTimeToRank(originalArray: [Int]) {
        print("originalArray \(originalArray)")
//        let sortedArray = originalArray.sorted(by: )
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
}

struct TouristSpot: Identifiable {
    let id = UUID()
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    let placeName: String
    let symbolName: String
}

#Preview {
    RouteDetailView()
}
