//
//  MKMapItemMarkerView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/04/2024.
//

import SwiftUI
import MapKit

struct MKMapItemMarker: MapMarkerModel {
    let mkMapItem: MKMapItem

    var id: Int {
        return mkMapItem.hash
    }

    var name: String {
        return mkMapItem.name ?? ""
    }

    var coordinates: CLLocationCoordinate2D {
        return mkMapItem.placemark.coordinate
    }

    // -------------------------------------------------------------------------
    // MARK: - Init
    // -------------------------------------------------------------------------

    init(mkMapItem: MKMapItem) {
        self.mkMapItem = mkMapItem
    }

    // -------------------------------------------------------------------------
    // MARK: - View
    // -------------------------------------------------------------------------

    @MapContentBuilder
    func buildMarker() -> some MapContent {
         Marker(item: mkMapItem)
    }
}

#Preview {
    Map {
        MKMapItemMarker(mkMapItem: .init(placemark: .init(
            coordinate: .cabaneClartan
        )))
        .buildMarker()
    }
}
