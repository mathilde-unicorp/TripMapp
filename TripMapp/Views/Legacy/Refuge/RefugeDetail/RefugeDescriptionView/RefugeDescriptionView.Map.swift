//
//  RefugeDescriptionView.Map.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 06/02/2024.
//

import SwiftUI
import MapKit

extension RefugeDescriptionView {
    struct AccessMap: View {
        let marker: TripMapMarker.ViewModel

        @State private var mapCameraPositon: MapCameraPosition = .automatic

        init(marker: TripMapMarker.ViewModel) {
            self.marker = marker
        }

        // ---------------------------------------------------------------------
        // MARK: - Body
        // ---------------------------------------------------------------------

        var body: some View {
            Map(position: $mapCameraPositon) {
                TripMapMarker(viewModel: marker)
            }
            .mapStyle(.hybrid(elevation: .realistic))
        }
    }
}

#Preview {
    RefugeDescriptionView.AccessMap(marker: .mocks.first!)
}
