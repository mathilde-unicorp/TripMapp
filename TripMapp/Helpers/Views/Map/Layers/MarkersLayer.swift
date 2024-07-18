//
//  SearchPointsOfInterestsLayer.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 08/04/2024.
//

import SwiftUI
import MapKit

struct MarkersLayer: MapContent {

    @Binding var markers: [TripPoint]

    var body: some MapContent {
        ForEach(markers, id: \.id) { marker in
            TripMapMarker(
                name: marker.name,
                coordinates: marker.coordinates,
                systemImage: marker.systemImage,
                color: marker.color
            )
        }
    }
}

#Preview {
    Map {
        MarkersLayer(
            markers: .constant(TripPoint.mocks)
        )
    }
}
