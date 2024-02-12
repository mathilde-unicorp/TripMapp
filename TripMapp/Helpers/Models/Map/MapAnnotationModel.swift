//
//  MapAnnotationModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 12/02/2024.
//

import Foundation
import SwiftUI
import MapKit

struct MapAnnotationModel {
    let id: Int
    let name: String
    let coordinates: CLLocationCoordinate2D
    let image: Image
}
