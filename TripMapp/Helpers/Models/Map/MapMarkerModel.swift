//
//  MapMarkerModel.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 12/02/2024.
//

import Foundation
import SwiftUI
import MapKit

struct MapMarkerModel: Identifiable {
    let id: Int
    let name: String
    let coordinates: CLLocationCoordinate2D
    let systemImage: String
}

extension MapMarkerModel: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

extension MapMarkerModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension MapMarkerModel {
    init(refuge: RefugesInfo.LightRefugePoint) {
        self.init(
            id: refuge.properties.id,
            name: refuge.properties.name,
            coordinates: refuge.geometry.coordinate2D,
            systemImage: refuge.properties.type.systemImage ?? ""
        )
    }
}
