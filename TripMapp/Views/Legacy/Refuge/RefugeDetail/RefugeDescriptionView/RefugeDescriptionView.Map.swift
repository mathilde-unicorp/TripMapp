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
        let marker: TripPoint

        @State private var mapCameraPositon: MapCameraPosition = .automatic

        init(marker: TripPoint) {
            self.marker = marker
        }

        // ---------------------------------------------------------------------
        // MARK: - Body
        // ---------------------------------------------------------------------

        var body: some View {
            Map(position: $mapCameraPositon) {
                TripMapMarker(
                    name: marker.name,
                    coordinates: marker.coordinates,
                    systemImage: marker.systemImage,
                    color: marker.color
                )
            }
            .mapStyle(.hybrid(elevation: .realistic))
        }
    }
}

#Preview {
    RefugeDescriptionView.AccessMap(marker: .mocks.first!)
}
