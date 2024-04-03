//
//  MassifModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 12/02/2024.
//

import Foundation
import MapKit
import SwiftUI

struct MapPolygonModel: Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
    let coordinates: [CLLocationCoordinate2D]
    let color: Color
}

extension MapPolygonModel {
    init(massif: RefugesInfo.MassifPolygon) {
        self.init(
            id: massif.properties.id,
            name: massif.properties.name,
            coordinates: massif.geometry.coordinates2D,
            color: UIColor(hex: massif.properties.colorHexa).swiftUiColor
        )
    }
}
