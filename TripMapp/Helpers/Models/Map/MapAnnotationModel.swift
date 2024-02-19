//
//  MapAnnotationModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 12/02/2024.
//

import Foundation
import SwiftUI
import MapKit

struct MapAnnotationModel: Identifiable {
    let id: Int
    let name: String
    let coordinates: CLLocationCoordinate2D
    let image: Image
}

extension MapAnnotationModel: Equatable {
    static func == (lhs: MapAnnotationModel, rhs: MapAnnotationModel) -> Bool {
        return lhs.id == rhs.id
    }
}

extension MapAnnotationModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension MapAnnotationModel {
    init(refuge: RefugesInfo.LightRefugePoint) {
        self.init(
            id: refuge.properties.id,
            name: refuge.properties.name,
            coordinates: refuge.geometry.coordinate2D,
            image: refuge.properties.type.icon
        )
    }
}
