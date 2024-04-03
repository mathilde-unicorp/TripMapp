//
//  MapPolylineModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 03/04/2024.
//

import Foundation
import MapKit
import SwiftUI

struct MapPolylineModel: Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
    let coordinates: [CLLocationCoordinate2D]
    let color: Color
}
