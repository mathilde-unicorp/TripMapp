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
        let marker: RefugesInfoMarker.ViewModel

        @State private var mapCameraPositon: MapCameraPosition = .automatic

        init(marker: RefugesInfoMarker.ViewModel) {
            self.marker = marker
        }

        // ---------------------------------------------------------------------
        // MARK: - Body
        // ---------------------------------------------------------------------

        var body: some View {
            Map(position: $mapCameraPositon) {
                RefugesInfoMarker(viewModel: marker)
            }
            .mapStyle(.hybrid(elevation: .realistic))
        }
    }
}

#Preview {
    RefugeDescriptionView.AccessMap(
        marker: .init(refugeInfoResult: MockRefuges.refuges.first!.toLightPoint)
    )
}
