import MapKit

extension CLLocationCoordinate2D: Identifiable, Equatable {
    public var id: Double {
        longitude + latitude
    }
    
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        let latitudeIsSame = lhs.latitude == rhs.latitude
        let longitudeIsSame = lhs.longitude == rhs.longitude
        return latitudeIsSame && longitudeIsSame
    }
}
