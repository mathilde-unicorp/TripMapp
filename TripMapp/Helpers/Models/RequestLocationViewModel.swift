//
//  LocationableObject.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/02/2024.
//

import Foundation
import CoreLocation

class RequestLocationViewModel: NSObject, ObservableObject {
    private let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?

    // -------------------------------------------------------------------------
    // MARK: - Init
    // -------------------------------------------------------------------------

    override init() {
        super.init()
        self.manager.delegate = self
    }

    func requestLocation() {
        self.manager.requestLocation()
    }
}

extension RequestLocationViewModel: CLLocationManagerDelegate {

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        print("get location: \(String(describing: locations.first?.coordinate))")

        let coordinates = locations.first?.coordinate
        self.location = coordinates

        // do not constantly update user location
        self.manager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager didFailWithError: \(error)")
    }
}
