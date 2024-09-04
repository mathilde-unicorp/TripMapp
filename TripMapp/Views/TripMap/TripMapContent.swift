//
//  TripMapContent.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 02/07/2024.
//

import SwiftUI
import MapKit

/// A MapContent with classic items for the current usages of the application
struct TripMapContent: MapContent {

    @Binding var markers: [TripPoint]
    @Binding var polylines: [TripMapPolyline.ViewModel]

    var body: some MapContent {
        MarkersLayer(markers: $markers)

        PolylinesLayer(polylines: $polylines)
    }
}

#Preview {
    Map {
        TripMapContent(
            markers: .constant(TripPoint.mocks),
            polylines: .constant(TripMapPolyline.ViewModel.mocks)
        )
    }
}
