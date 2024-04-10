//
//  SearchPointsOfInterestsLayer.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 08/04/2024.
//

import SwiftUI
import MapKit

struct MarkersLayer: MapContent {

    @Binding var markers: [TripMapMarker.ViewModel]

    var body: some MapContent {
        ForEach(markers, id: \.id) {
            TripMapMarker(viewModel: $0)
        }
    }
}

#Preview {
    Map {
        MarkersLayer(
            markers: .constant([
                .init(refugeInfoResult: MockRefuges.refuges.first!.toLightPoint,
                      type: .cottage),
                .init(mkMapItem: .init(placemark: .init(coordinate: .france)),
                      type: .waypoint),
                .init(mkMapItem: .init(placemark: .init(coordinate: .giteDeLaColleStMichel)),
                      type: .hotel)
            ])
        )
    }
}
