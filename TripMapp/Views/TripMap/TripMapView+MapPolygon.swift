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
    static func build(polygons: [MapPolygonModel]) -> some MapContent {
        ForEach(polygons, id: \.id) { polygon in
            build(polygon: polygon)
        }
    }

    @MapContentBuilder
    static func build(polygon: MapPolygonModel) -> some MapContent {
        MapPolygon(coordinates: polygon.coordinates)
            .foregroundStyle(polygon.color.opacity(0.5))
            .stroke(polygon.color, lineWidth: 3.0)

        Marker(
            polygon.name,
            systemImage: "mountain.2",
            coordinate: polygon.coordinates.calculateCentralPoint() ?? .zero
        )
        .tint(polygon.color)
    }
}

#Preview {
    Map {
        TripMapView.build(polygons: [
            .init(id: 0, name: "Test", coordinates: MockMassifs.massifs.first!.geometry.coordinates2D, color: .green)
        ])
    }
}
