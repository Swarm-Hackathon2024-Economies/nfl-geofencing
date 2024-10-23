import MapKit
import SwiftUI

struct MapViewForScreenShot: View {
    let repository = TrafficAccidentRepository()
    @State private var trafficAccidents: [TrafficAccident] = []
    
    var body: some View {
        Map {
            ForEach(trafficAccidents) { accident in
                Annotation("", coordinate: CLLocationCoordinate2D(latitude: accident.latitude, longitude: accident.longitude)) {
                    Text("\(accident.aadt)")
                }
                MapCircle(center: CLLocationCoordinate2D(latitude: accident.latitude, longitude: accident.longitude), radius: 100)
                    .foregroundStyle(Color.init(red: calcRed(for: accident), green: 0, blue: 1).opacity(0.3))
            }
        }
        .preferredColorScheme(.light)
        .onAppear {
            trafficAccidents = repository.getAll()
        }
    }
    
    private func calcRed(for accident: TrafficAccident) -> CGFloat {
        let aadtList = trafficAccidents.map { $0.aadt }
        guard let max = aadtList.max() else { return 0 }
        return accident.aadt / max
    }
}

#Preview {
    MapViewForScreenShot()
}
