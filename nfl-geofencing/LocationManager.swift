import SwiftUI
import CoreLocation
import MapKit


class FakeLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var coordinate: CLLocationCoordinate2D? = Place.tmna.placemark.coordinate
    @Published var updatingFinished: Bool = false

    var routePolyline: MKPolyline? {
        didSet {
            guard let routePolyline else { return }
            routeCoordinates = routePolyline.getCoordinates()
        }
    }

    var willChangeCoordinate: ((_ current: CLLocationCoordinate2D, _ next: CLLocationCoordinate2D) -> Void)?

    private var routeCoordinates: [CLLocationCoordinate2D] = []
    private var timer: Timer?
    var currentStepIndex: Int = 0

    private let updateInterval: TimeInterval = 1.5
    private let speed: Double = 50.0

    private var distanceToNextCoordinate: Double = 0.0
    private var currentCoordinate: CLLocationCoordinate2D?

    override init() {
        super.init()
    }

    func startUpdatingLocation() {
        self.currentStepIndex = 0
        self.currentCoordinate = routeCoordinates.first
        guard let polyline = routePolyline else { return }
        timer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { _ in
            self.updateFakeLocation(with: polyline)
        }
    }

    private func updateFakeLocation(with polyline: MKPolyline) {
        let polylineCoordinates = polyline.getCoordinates()
        guard currentStepIndex < polylineCoordinates.count - 1 else {
            stopUpdatingLocation()
            return
        }
        let currentCoordinate = polylineCoordinates[currentStepIndex]
        let nextCoordinate = polylineCoordinates[currentStepIndex + 1]
        DispatchQueue.main.async {
            self.willChangeCoordinate?(currentCoordinate, nextCoordinate)
            self.coordinate = nextCoordinate
        }
        currentStepIndex += 1
    }

    func stopUpdatingLocation() {
        timer?.invalidate()
        timer = nil
        updatingFinished = true
    }
}

extension CLLocationCoordinate2D {
    func interpolate(to: CLLocationCoordinate2D, fraction: Double) -> CLLocationCoordinate2D {
        let latitude = self.latitude + (to.latitude - self.latitude) * fraction
        let longitude = self.longitude + (to.longitude - self.longitude) * fraction
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    func distance(to: CLLocationCoordinate2D) -> Double {
        let location1 = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let location2 = CLLocation(latitude: to.latitude, longitude: to.longitude)
        return location1.distance(from: location2)
    }
}


