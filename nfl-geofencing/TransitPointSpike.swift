import SwiftUI
import MapKit

struct TransitPointSpike: View {
    @State private var routes1: [MKRoute] = []
    @State private var routes2: [MKRoute] = []
    @State private var position: MapCameraPosition = .automatic
    @State private var dangerArea: [CircleArea] = []
    let dangerAreaRepository: DangerAreaRepository = JsonDangerAreaRepository()
    
    var body: some View {
        Map(position: $position) {
            ForEach(routes1, id: \.self) { route1 in
                MapPolyline(route1)
                    .stroke(.blue, lineWidth: 5)
            }
            ForEach(routes2, id: \.self) { route2 in
                MapPolyline(route2)
                    .stroke(.red, lineWidth: 5)
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
            getRoute()
            dangerArea = dangerAreaRepository.getAll()
        }
    }
    
    private func getRoute() {
        let tangentPoints = calculateTangentPoints(
            circleCenterCoordinate: Place.greatHeartsIrvingUpperSchool.placemark.coordinate,
            radius: 4000 / 111000,
            pointCoordinate: Place.tmna.placemark.coordinate
        )
        guard let firstTangentPoint = tangentPoints.first else { return }
        
        let request1 = MKDirections.Request()
        request1.requestsAlternateRoutes = true
        request1.source = Place.tmna
        request1.destination = Place.atAndTStadium
        
        Task {
            let directions1 = MKDirections(request: request1)
            let response1 = try? await directions1.calculate()
        
            self.routes1 = response1?.routes ?? []
        }
    }
}

func calculateTangentPoints(
    circleCenterCoordinate: CLLocationCoordinate2D,
    radius r: Double,
    pointCoordinate: CLLocationCoordinate2D
) -> [(Double, Double)] {
    let cx = circleCenterCoordinate.longitude
    let cy = circleCenterCoordinate.latitude
    
    let px = pointCoordinate.longitude
    let py = pointCoordinate.latitude
    
    let d = sqrt((px - cx) * (px - cx) + (py - cy) * (py - cy))
    
    guard d > r else { return [] }
    
    let a = asin(r / d)
    let b = atan2(py - cy, px - cx)
    
    let t1 = b - a
    let t2 = b + a
    
    let tangent1X = cx + r * sin(t1)
    let tangent1Y = cy + r * -cos(t1)
    let tangent2X = cx + r * sin(t2)
    let tangent2Y = cy + r * -cos(t2)
    
    return [(tangent1X, tangent1Y), (tangent2X, tangent2Y)]
}

#Preview {
    TransitPointSpike()
}
