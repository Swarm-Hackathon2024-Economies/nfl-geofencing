import SwiftUI
import MapKit

struct RouteNavigationView: View {
    @ObservedObject var locationManager: FakeLocationManager
    @State private var position: MapCameraPosition = .automatic
    @State private var route: MKRoute?
    @State private var coordinatesOnRoute: [CLLocationCoordinate2D] = []
    @State private var passedCoordinates: [CLLocationCoordinate2D] = []
    @Binding var instruction: Instruction
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
            getRoute()
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
            
            let currentStep = getCurrentStep(for: coordinate)
            instruction.text = currentStep?.instructions
            guard let currentStep else { return }
            updateRemainingDistance(of: currentStep, from: coordinate)
        }
        .preferredColorScheme(.dark)
    }
    
    private func getCurrentStep(for currentLocation: CLLocationCoordinate2D) -> MKRoute.Step? {
        guard let route else { return nil }
        let step = route.steps.first { step in
            let coordinates = step.polyline.getCoordinates()
            return coordinates.contains(currentLocation)
        }
        return step
    }
    
    private func updateRemainingDistance(of step: MKRoute.Step, from currentLocation: CLLocationCoordinate2D) {
        let stepCoordinates = step.polyline.getCoordinates()
        let currentIndexInStep = stepCoordinates.firstIndex(of: currentLocation) ?? 0
        
        var remainingDistance: Double = 0
        for index in currentIndexInStep..<stepCoordinates.count {
            guard let current = stepCoordinates[safe: index] else { break }
            guard let next = stepCoordinates[safe: index + 1] else { break }
            let currentLocation = CLLocation(latitude: current.latitude, longitude: current.longitude)
            let nextLocation = CLLocation(latitude: next.latitude, longitude: next.longitude)
            remainingDistance += nextLocation.distance(from: currentLocation)
        }
        withAnimation {
            instruction.distance = Int(remainingDistance)
        }
    }
    
    private func calculateAngle(from start: CLLocationCoordinate2D, to next: CLLocationCoordinate2D) -> Double {
        let deltaLongitude = next.longitude - start.longitude
        let deltaLatitude = next.latitude - start.latitude
        let angle = atan2(deltaLongitude, deltaLatitude) * (180 / .pi)
        let result = angle >= 0 ? angle : angle + 360
        return result
    }
    
    private func getRoute() {
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
            adjustCameraPosition(for: coordinates[0], and: coordinates[1])
        }
    }
    
    private func willChangeCoordinate(_ current: CLLocationCoordinate2D, _ next: CLLocationCoordinate2D) {
        adjustCameraPosition(for: current, and: next)
    }
    
    private func adjustCameraPosition(for currentPosition: CLLocationCoordinate2D, and nextPosition: CLLocationCoordinate2D) {
        withAnimation {
            position = .camera(
                MapCamera(
                    centerCoordinate: nextPosition,
                    distance: 300,
                    heading: calculateAngle(from: currentPosition, to: nextPosition),
                    pitch: 40
                )
            )
        }
    }
}


#Preview {
    RouteNavigationView(
        locationManager: FakeLocationManager(),
        instruction: .constant(Instruction()),
        totalPoints: .constant(0)
    )
}
