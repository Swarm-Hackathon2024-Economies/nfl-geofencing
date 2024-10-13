import MapKit

struct Place {
    static let tmna = {
        let item = MKMapItem(
            placemark: MKPlacemark(
                coordinate: CLLocationCoordinate2D(
                    latitude: 33.08575588060863,
                    longitude: -96.83921907513722
                )
            )
        )
        item.name = "Toyota Motor North America, Inc."
        return item
    }()
    
    static let walmart = {
        let item = MKMapItem(
            placemark: MKPlacemark(
                coordinate: CLLocationCoordinate2D(
                    latitude: 33.09894497818888,
                    longitude: -96.7971603902402
                )
            )
        )
        item.name = "Walmart Neighborhood Market"
        return item
    }()
    
    static let atAndTStadium = {
        let item = MKMapItem(
            placemark: MKPlacemark(
                coordinate: CLLocationCoordinate2D(
                    latitude: 32.74816795373609,
                    longitude: -97.09333068671008
                )
            )
        )
        item.name = "AT&T Stadium"
        return item
    }()
    
    static let greatHeartsIrvingUpperSchool = {
        let item = MKMapItem(
            placemark: MKPlacemark(
                coordinate: CLLocationCoordinate2D(
                    latitude: 32.881103028406834,
                    longitude: -96.99292883215352
                )
            )
        )
        item.name = "Great Hearts Irving Upper School"
        return item
    }()
}
