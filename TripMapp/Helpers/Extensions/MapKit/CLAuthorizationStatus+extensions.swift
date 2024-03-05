//
//  CLAuthorizationStatus+extensions.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/03/2024.
//

import Foundation
import MapKit

extension CLAuthorizationStatus {
    /// Does the granted authorization allow the app to access to expected data
    var isAuthorized: Bool {
        switch self {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        default:
            return false
        }
    }
}
