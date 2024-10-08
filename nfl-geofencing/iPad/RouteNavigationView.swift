import SwiftUI
import MapKit

extension CLLocationCoordinate2D: Identifiable {
    public var id: Double {
        longitude + latitude
    }
}

struct RouteNavigationView: View {
    @ObservedObject var locationManager: FakeLocationManager
    @State private var position: MapCameraPosition = .automatic
    @State private var route: MKRoute?
    @State private var coordinatesOnRoute: [CLLocationCoordinate2D] = []
    @State private var passedCoordinates: [CLLocationCoordinate2D] = []
    @Binding var totalPoints: Int
    
    var body: some View {
        Map(position: $position) {
            if let coordinate = locationManager.coordinate {
                Annotation("", coordinate: coordinate) {
                    Image(systemName: "location.north.fill")
                        .foregroundStyle(.blue)
                        .offset(y: 5)
                        .padding()
                        .background(Circle().fill(.white.opacity(0.7)).rotation3DEffect(.degrees(40), axis: (x: 1.0, y: 0.0, z: 0.0)))
                }
            }
            
            ForEach(coordinatesOnRoute.dropFirst()) { coordinate in
                Annotation("", coordinate: coordinate, anchor: .bottomLeading) {
                    Image(systemName: "football.fill")
                        .font(.title)
                        .foregroundStyle(.brown)
                        .padding(4)
                        .opacity(passedCoordinates.contains(coordinate) ? 0 : 1)
                }
            }
            
            if let route {
                MapPolyline(route)
                    .stroke(.blue, lineWidth: 5)
            }
        }
        .animation(.linear, value: locationManager.coordinate)
        .transition(.asymmetric(insertion: .scale, removal: .slide))
        .mapStyle(.standard(elevation: .flat))
        .onAppear {
            locationManager.willChangeCoordinate = self.willChangeCoordinate
            getDirections()
        }
        .onChange(of: locationManager.coordinate) { oldValue, newValue in
            if oldValue == nil { return }
            guard let coordinate = newValue else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    totalPoints += 12
                    passedCoordinates.append(coordinate)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private func calculateAngle(from start: CLLocationCoordinate2D, to next: CLLocationCoordinate2D) -> Double {
        let deltaLongitude = next.longitude - start.longitude
        let deltaLatitude = next.latitude - start.latitude
        let angle = atan2(deltaLongitude, deltaLatitude) * (180 / .pi)
        let result = angle >= 0 ? angle : angle + 360
        return result
    }
    
    private func getDirections() {
        let request = MKDirections.Request()
        request.source = Place.tmna
        request.destination = Place.atAndTStadium
        
        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            guard let route = response?.routes.first else { return }
            
            locationManager.routePolyline = route.polyline
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                locationManager.startUpdatingLocation()
            }
            
            self.route = route
            let coordinates = route.polyline.getCoordinates()
            coordinatesOnRoute = coordinates
            locationManager.coordinate = coordinates.first
            if coordinates.count < 2 { return }
            withAnimation {
                position = .camera(
                    MapCamera(
                        centerCoordinate: coordinates[0],
                        distance: 300,
                        heading: calculateAngle(from: coordinates[0], to: coordinates[1]),
                        pitch: 40
                    )
                )
            }
        }
    }
    
    private func willChangeCoordinate(_ current: CLLocationCoordinate2D, _ next: CLLocationCoordinate2D) {
        withAnimation {
            position = .camera(
                MapCamera(
                    centerCoordinate: next,
                    distance: 300,
                    heading: calculateAngle(from: current, to: next),
                    pitch: 40
                )
            )
        }
    }
}



#Preview {
    RouteNavigationView(locationManager: FakeLocationManager(), totalPoints: .constant(0))
}
