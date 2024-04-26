//
//  TripLine.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/05/2024.
//

import Foundation
import MapKit

struct TripTrace: Identifiable, Hashable {
    let id: UUID = UUID()

    var name: String
    var trace: [CLLocationCoordinate2D]
}
