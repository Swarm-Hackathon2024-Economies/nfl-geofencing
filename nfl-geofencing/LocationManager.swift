import SwiftUI
import CoreLocation
import MapKit


class FakeLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var coordinate: CLLocationCoordinate2D? = Place.tmna.placemark.coordinate
    @Published var updatingFinished: Bool = false
    
    var routePolyline: MKPolyline?
    var willChangeCoordinate: ((_ current: CLLocationCoordinate2D, _ next: CLLocationCoordinate2D) -> Void)?
    
    private var timer: Timer?
    var currentStepIndex: Int = 0
    
    private let updateInterval: TimeInterval = 2
    private let speed: Double = 50.0

    override init() {
        super.init()
    }

    func startUpdatingLocation() {
        self.currentStepIndex = 0
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

