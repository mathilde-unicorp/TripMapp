//
//  TripMapView+MapPolygon.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 03/04/2024.
//

import SwiftUI
import MapKit

// =============================================================================
// MARK: - Massifs
// =============================================================================

extension TripMapView {

    @MapContentBuilder
    static func build(massifs: [MapPolygonModel]) -> some MapContent {
        ForEach(massifs, id: \.id) { massif in
            build(massif: massif)
        }
    }

    @MapContentBuilder
    static func build(massif: MapPolygonModel) -> some MapContent {
        MapPolygon(coordinates: massif.coordinates)
            .foregroundStyle(massif.color.opacity(0.5))
            .stroke(massif.color, lineWidth: 3.0)

        Marker(
            massif.name,
            systemImage: "mountain.2",
            coordinate: massif.coordinates.calculateCentralPoint() ?? .zero
        )
        .tint(massif.color)
    }
}

#Preview {
    Map {
        TripMapView.build(massifs: [
            .init(id: 0, name: "Test", coordinates: MockMassifs.massifs.first!.geometry.coordinates2D, color: .green)
        ])
    }
}
