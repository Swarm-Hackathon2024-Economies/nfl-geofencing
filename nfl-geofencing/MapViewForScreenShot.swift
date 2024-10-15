import MapKit
import SwiftUI

struct MapViewForScreenShot: View {
    let repository = JsonDangerAreaRepository()
    @State private var dangerArea: [CircleArea] = []
    
    var body: some View {
        Map {
            ForEach(dangerArea) { area in
                MapCircle(center: CLLocationCoordinate2D(latitude: area.latitude, longitude: area.longitude), radius: 100)
                    .foregroundStyle(.red.opacity(0.3))
            }
        }
        .onAppear {
            dangerArea = repository.getAll()
        }
    }
}

#Preview {
    MapViewForScreenShot()
}
