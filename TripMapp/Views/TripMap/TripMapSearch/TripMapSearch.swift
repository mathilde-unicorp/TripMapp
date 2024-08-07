//
//  MapSearchContent.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 03/07/2024.
//

import SwiftUI
import MapKit

struct TripMapSearch: View {

    /// Points Of Interest Types to search on the map
    @Binding var searchTripPointTypes: [TripPointType]
    @Binding var selectedMarker: TripMapMarker.ViewModel?

    @ObservedObject var dataSource: TripMapSearchDataSource

    @State private var localSelectedItem: String?
    @State private var searchOnRegion: MKCoordinateRegion?
    @State private var shouldShowRefreshButton: Bool = false

    // -------------------------------------------------------------------------
    // MARK: - Init
    // -------------------------------------------------------------------------

    init(
        searchTripPointTypes: Binding<[TripPointType]>,
        selectedMarker: Binding<TripMapMarker.ViewModel?>,
        dataSource: TripMapSearchDataSource = .init(mapItemsRepository: .shared)
    ) {
        self._searchTripPointTypes = searchTripPointTypes
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
        .onChange(of: searchTripPointTypes) { _, _ in
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
                ofTypes: searchTripPointTypes,
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
    TripMapSearch(
        searchTripPointTypes: .constant([.refuge, .foodstuffProvisions]),
        selectedMarker: .constant(nil),
        dataSource: .init(mapItemsRepository: .mock)
    )
}
