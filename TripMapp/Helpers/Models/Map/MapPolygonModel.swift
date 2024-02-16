//
//  MassifModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 12/02/2024.
//

import Foundation
import MapKit
import SwiftUI

struct MapPolygonModel: Identifiable {
    let id: Int
    let name: String
    let coordinates: [CLLocationCoordinate2D]
    let color: Color
}

extension MapPolygonModel: Equatable {
    static func == (lhs: MapPolygonModel, rhs: MapPolygonModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension MapPolygonModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
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
