//
//  SearchResultMarker.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 09/04/2024.
//

import SwiftUI
import MapKit

struct TripMapMarker: MapContent {

    let name: String
    let coordinates: CLLocationCoordinate2D
    let systemImage: String
    let color: Color

    var body: some MapContent {
        Marker(
            name,
            systemImage: systemImage,
            coordinate: coordinates
        )
        .tint(color)
    }
}

#Preview {
    Map {
        TripMapMarker(
            name: "Marker name",
            coordinates: .giteDeLaColleStMichel,
            systemImage: "mappin",
            color: .red
        )
    }
}
