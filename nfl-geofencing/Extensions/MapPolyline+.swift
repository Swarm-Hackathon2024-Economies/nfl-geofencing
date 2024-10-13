import MapKit

extension MKPolyline {
    func getCoordinates() -> [CLLocationCoordinate2D] {
        var polylineCoordinates = Array(
            repeating: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            count: pointCount
        )
        getCoordinates(&polylineCoordinates, range: NSRange(location: 0, length: pointCount))
        return polylineCoordinates
    }
}
