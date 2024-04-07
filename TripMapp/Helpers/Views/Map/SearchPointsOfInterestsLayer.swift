//
//  SearchPointsOfInterestsLayer.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 08/04/2024.
//

import SwiftUI
import MapKit

struct SearchPointsOfInterestsLayer: MapContent {

    @Binding var refugesInfoResults: [RefugesInfoMarker.ViewModel]
    @Binding var mkMapItemsResults: [MKMapItemMarker.ViewModel]

    var body: some MapContent {
        ForEach(refugesInfoResults, id: \.id) {
            RefugesInfoMarker(viewModel: $0)
        }

        ForEach(mkMapItemsResults, id: \.id) {
            MKMapItemMarker(viewModel: $0)
        }
    }
}

#Preview {
    Map {
        SearchPointsOfInterestsLayer(
            refugesInfoResults: .constant(MockRefuges.refuges.map {
                .init(refugeInfoResult: $0.toLightPoint)
            }),
            mkMapItemsResults: .constant([
                .init(mkMapItem: .init(placemark: .init(coordinate: .france))),
                .init(mkMapItem: .init(placemark: .init(coordinate: .giteDeLaColleStMichel)))
            ])
        )
    }
}
