//
//  PolylinesLayer.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 02/07/2024.
//

import SwiftUI
import MapKit

struct PolylinesLayer: MapContent {

    @Binding var polylines: [TripMapPolyline.ViewModel]

    var body: some MapContent {
        ForEach(polylines, id: \.id) {
            TripMapPolyline(viewModel: $0)
        }
    }
}

#Preview {
    Map {
        PolylinesLayer(polylines: .constant(TripMapPolyline.ViewModel.mocks))
    }
}
