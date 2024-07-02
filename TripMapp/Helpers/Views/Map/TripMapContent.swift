//
//  TripMapContent.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 02/07/2024.
//

import SwiftUI
import MapKit

struct TripMapContent: MapContent {

    @Binding var markers: [TripMapMarker.ViewModel]
    @Binding var polylines: [TripMapPolyline.ViewModel]

    var body: some MapContent {
        MarkersLayer(markers: $markers)

        PolylinesLayer(polylines: $polylines)
    }
}

#Preview {
    Map {
        TripMapContent(
            markers: .constant(TripMapMarker.ViewModel.mocks),
            polylines: .constant(TripMapPolyline.ViewModel.mocks)
        )
    }
}
