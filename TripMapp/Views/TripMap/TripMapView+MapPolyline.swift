//
//  TripMapView+MapPolyline.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 03/04/2024.
//

import SwiftUI
import MapKit

extension TripMapView {

    @MapContentBuilder
    static func build(polylines: [MapPolylineModel]) -> some MapContent {
        ForEach(polylines, id: \.id) { polyline in
            build(polyline: polyline)
        }
    }

    @MapContentBuilder
    static func build(polyline: MapPolylineModel) -> some MapContent {
        MapPolyline(coordinates: polyline.coordinates)
            .foregroundStyle(.clear)
            .stroke(polyline.color, lineWidth: 3.0)

        if let firstCoordinates = polyline.coordinates.first {
            Marker(coordinate: firstCoordinates) {
                Label(polyline.name, systemImage: "figure.walk")
            }
        }
    }

}

#Preview {
    Map {
        TripMapView.build(polyline:
            .init(id: 0, name: "Test", coordinates: MockMassifs.massifs.first!.geometry.coordinates2D, color: .green)
        )
    }
}
