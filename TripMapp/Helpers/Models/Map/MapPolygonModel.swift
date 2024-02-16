//
//  MassifModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 12/02/2024.
//

import Foundation
import MapKit
import SwiftUI

struct MapPolygonModel {
    let id: Int
    let name: String
    let coordinates: [CLLocationCoordinate2D]
    let color: Color
}
