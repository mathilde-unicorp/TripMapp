//
//  CLLocationManagerObject.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/03/2024.
//

import Foundation
import CoreLocation

class CLLocationManagerObject: NSObject, ObservableObject {

    /// Observable locationAuthoization
    @Published var locationAuthorization: CLAuthorizationStatus

    private var locationManager: CLLocationManager

    // -------------------------------------------------------------------------
    // MARK: - Init
    // -------------------------------------------------------------------------
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        self.locationAuthorization = locationManager.authorizationStatus
        super.init()

        self.locationManager.delegate = self

    }
}

// =============================================================================
// MARK: - CLLocationManagerDelegate
// =============================================================================

extension CLLocationManagerObject: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationAuthorization = manager.authorizationStatus

        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            // Insert code here of what should happen when Location services are authorized
            locationManager.requestLocation()
            break
        case .restricted, .denied:
            // Insert code here of what should happen when Location services are NOT authorized
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locationManager didUpdateLocations: \(locations)")
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("locationManager didFailWithError: \(error)")
    }
}
