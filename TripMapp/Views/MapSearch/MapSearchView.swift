//
//  MapSearchView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 02/07/2024.
//

import SwiftUI
import MapKit

struct MapSearchView: View {

    @Binding var visibleRegion: MKCoordinateRegion?

    @Binding var markers: [TripMapMarker.ViewModel]
    @Binding var polylines: [TripMapPolyline.ViewModel]

    @Binding var selectedItem: UUID?

    var onRefreshResult: () -> Void

    /// Local visible region allows the map to move and track user position even if nothing is passed in `visibleRegion` binding
    @State private var localVisibleRegion: MKCoordinateRegion?

    @State private var shouldShowRefreshSearch: Bool = false

    var body: some View {
        TripMap(
            visibleRegion: $localVisibleRegion,
            selectedItem: $selectedItem
        ) {
            TripMapContent(
                markers: $markers,
                polylines: $polylines
            )
        }
        .onChange(of: localVisibleRegion) { oldRegion, newRegion in
            self.visibleRegion = newRegion

            guard oldRegion != nil, oldRegion != newRegion else { return }

            withAnimation {
                self.shouldShowRefreshSearch = true
            }
        }
        .overlay(alignment: .top) {
            if shouldShowRefreshSearch {
                RefreshMapButton {
                    onRefreshResult()

                    withAnimation {
                        shouldShowRefreshSearch = false
                    }
                }
            }
        }
    }
}

#Preview {
    MapSearchView(
        visibleRegion: .constant(nil),
        markers: .constant([]),
        polylines: .constant([]),
        selectedItem: .constant(nil),
        onRefreshResult: { print("refresh stuff") }
    )
}
