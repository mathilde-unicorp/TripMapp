//
//  TripMapView+MapContent.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 03/04/2024.
//

import SwiftUI
import MapKit

extension TripMapView {

    @MapContentBuilder
    static func build(mapMarkers: [TripMapMarker]) -> some MapContent {
        ForEach(mapMarkers, id: \.self) { marker in
            build(mapMarker: marker)
        }
    }

    @MapContentBuilder
    static func build(mapMarker: TripMapMarker) -> some MapContent {
        switch mapMarker {
        case .mkMapItem(let mKMapItem):
            Marker(item: mKMapItem)
        case .marker(let model):
            Marker(
                model.name,
                systemImage: model.systemImage,
                coordinate: model.coordinates
            )
        }
    }
}

#Preview {
    Map {
        TripMapView.build(mapMarkers: [
            .marker(.init(
                id: 0,
                name: "Cabane de Clartan",
                coordinates: .cabaneClartan,
                systemImage: "bed.double"
            )),
            .marker(.init(
                id: 1,
                name: "Gite de la Colle St Michel",
                coordinates: .giteDeLaColleStMichel,
                systemImage: "bed.double"
            ))
        ])
    }
}
