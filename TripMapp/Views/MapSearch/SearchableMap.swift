//
//  MapSearchView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 02/07/2024.
//

import SwiftUI
import MapKit

struct SearchableMap<SearchableMapContent: MapContent>: View {

    @Binding var searchOnRegion: MKCoordinateRegion?

//    @Binding var markers: [TripMapMarker.ViewModel]
//    @Binding var polylines: [TripMapPolyline.ViewModel]

    @Binding var selectedItem: String?

    var onRefreshResult: () -> Void

    @MapContentBuilder
    var mapContent: () -> SearchableMapContent

    /// Local visible region allows the map to move and track user position 
    /// even if nothing is passed in `visibleRegion` binding
    @State private var localVisibleRegion: MKCoordinateRegion?

    @State private var shouldShowRefreshSearch: Bool = false

    var body: some View {
        TripMap(
            visibleRegion: $localVisibleRegion,
            selectedItem: $selectedItem
        ) {
            mapContent()
        }
        .onChange(of: localVisibleRegion) { oldRegion, newRegion in
            self.searchOnRegion = newRegion

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
    SearchableMap(
        searchOnRegion: .constant(nil),
        selectedItem: .constant("0"),
        onRefreshResult: { print("refresh stuff") },
        mapContent: {
            MarkersLayer(markers: .constant(TripMapMarker.ViewModel.mocks))
        }
    )
}
