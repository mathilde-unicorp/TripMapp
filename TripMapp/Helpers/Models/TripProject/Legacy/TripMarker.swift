//
//  TripProject.Marker.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/05/2024.
//

import Foundation
import MapKit

struct TripMarker: Identifiable, Hashable {
    let id: UUID = UUID()

    var name: String
    var systemImage: String
    var coordinate: CLLocationCoordinate2D
}
