//
//  CLLocationCoordinate2D+extensions.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 06/02/2024.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D {
    static let zero = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)

    static let cabaneClartan = CLLocationCoordinate2D(
        latitude: 45.50609,
        longitude: 6.37203
    )

    static let giteDeLaColleStMichel = CLLocationCoordinate2D(
        latitude: 44.04703,
        longitude: 6.59309
    )

    static let france = CLLocationCoordinate2D(
        latitude: 46.1106885,
        longitude: 2.5911028
    )
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude
        && lhs.longitude == rhs.longitude
    }
}

extension CLLocationCoordinate2D: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(latitude)
        hasher.combine(longitude)
    }
}
