//
//  MKMapItemMarkerView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/04/2024.
//

import SwiftUI
import MapKit

struct MKMapItemMarker: MapContent {

    struct ViewModel {
        let id: UUID = UUID()

        let mkMapItem: MKMapItem
    }

    var id: UUID { return viewModel.id }

    let viewModel: ViewModel

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some MapContent {
        Marker(item: viewModel.mkMapItem)
    }
}

#Preview {
    Map {
        MKMapItemMarker(viewModel: .init(
            mkMapItem: .init(placemark: .init(coordinate: .cabaneClartan))
        ))
    }
}
