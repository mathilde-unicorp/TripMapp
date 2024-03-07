//
//  RefugeDescriptionView.Map.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 06/02/2024.
//

import SwiftUI
import MapKit

extension RefugeDescriptionView {
    struct Map: View {
        let marker: MapMarkerModel

        init(marker: MapMarkerModel) {
            self.marker = marker
        }

        init(viewModel: ViewModel) {
            self.marker = .init(
                id: viewModel.placeId,
                name: "",
                coordinates: viewModel.coordinate,
                systemImage: viewModel.systemImage
            )
        }

        // ---------------------------------------------------------------------
        // MARK: - Body
        // ---------------------------------------------------------------------

        var body: some View {
            RefugesMapView(
                mapMarkers: .constant([.marker(marker)]),
                mapCameraPosition: .constant(.automatic),
                selectedRefugeId: .constant(nil)
            )
        }
    }
}

#Preview {
    RefugeDescriptionView.Map(viewModel: .mock())
}
