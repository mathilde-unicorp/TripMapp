//
//  MapSearchContent.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 03/07/2024.
//

import SwiftUI
import MapKit

struct MapSearchByPOITypeView: View {

    /// Points Of Interest Types to search on the map
    @Binding var searchPOITypes: [POIType]
    @Binding var selectedMarker: TripMapMarker.ViewModel?

    @ObservedObject var dataSource: MapSearchByPOITypeDataSource

    @State private var localSelectedItem: String?
    @State private var searchOnRegion: MKCoordinateRegion?
    @State private var shouldShowRefreshButton: Bool = false

    // -------------------------------------------------------------------------
    // MARK: - Init
    // -------------------------------------------------------------------------

    init(
        searchPOITypes: Binding<[POIType]>,
        selectedMarker: Binding<TripMapMarker.ViewModel?>,
        dataSource: MapSearchByPOITypeDataSource = .init(mapItemsRepository: .shared)
    ) {
        self._searchPOITypes = searchPOITypes
        self._selectedMarker = selectedMarker
        self.dataSource = dataSource
    }

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        TripMap(
            visibleRegion: $searchOnRegion,
            selectedItem: $localSelectedItem
        ) {
            MarkersLayer(markers: $dataSource.searchResults)
        }
        .mapRefreshable(
            isVisible: $shouldShowRefreshButton,
            onRefresh: refreshMapResults
        )
        .overlay(alignment: .top) {
            MapLoadingIndicator(loadingState: $dataSource.loadingState)
        }
        .onChange(of: searchPOITypes) { _, _ in
            // When the PointOfInterest types selected changed, update the map results
            self.refreshMapResults()
        }
        .onChange(of: searchOnRegion) { oldRegion, newRegion in
            // when the visible region changed, show the refresh button
            guard oldRegion != nil, oldRegion != newRegion else { return }

            withAnimation { self.shouldShowRefreshButton = true }
        }
        .onChange(of: localSelectedItem) { _, newSelectedItem in
            onSelectedItemChanged(newSelectedItem)
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Actions
    // -------------------------------------------------------------------------

    private func refreshMapResults() {
        withAnimation {
            self.localSelectedItem = nil

            self.shouldShowRefreshButton = false

            self.dataSource.searchMapItems(
                ofTypes: searchPOITypes,
                on: searchOnRegion
            )
        }
    }

    private func onSelectedItemChanged(_ newSelectedItem: String?) {
        var newMarker: TripMapMarker.ViewModel?

        if let markerId = newSelectedItem {
            newMarker = self.dataSource.searchResults.first(keyPath: \.id, equals: markerId)
        } else {
            newMarker = nil
        }

        withAnimation {
            self.selectedMarker = newMarker
        }
    }
}

#Preview {
    MapSearchByPOITypeView(
        searchPOITypes: .constant([.refuge, .foodstuffProvisions]),
        selectedMarker: .constant(nil),
        dataSource: .init(mapItemsRepository: .mock)
    )
}
