//
//  MapSearchContent.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 03/07/2024.
//

import SwiftUI
import MapKit

struct TripMapSearch: View {

    // -------------------------------------------------------------------------
    // MARK: - Parameters
    // -------------------------------------------------------------------------

    /// Types of point to search on the map
    @Binding var searchTripPointTypes: [TripPointType]
    /// The marker selected on the map
    @Binding var selectedMarker: TripPoint?

    // -------------------------------------------------------------------------
    // MARK: - Private
    // -------------------------------------------------------------------------

    /// Data source to use to make research on the map
    @ObservedObject private var dataSource: TripMapSearchDataSource

    /// The local selected item id
    @State private var localSelectedItem: String?
    /// The  region we are searching results for
    @State private var searchOnRegion: MKCoordinateRegion?
    /// Should the refresh button be shown on the map
    @State private var shouldShowRefreshButton: Bool = false

    // -------------------------------------------------------------------------
    // MARK: - Init
    // -------------------------------------------------------------------------

    init(
        searchTripPointTypes: Binding<[TripPointType]>,
        selectedMarker: Binding<TripPoint?>,
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
            selectedItemId: $localSelectedItem
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
            // When the selected point types changed, update the map results
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
        }

        self.dataSource.searchMapItems(
            ofTypes: searchTripPointTypes,
            on: searchOnRegion
        )
    }

    private func onSelectedItemChanged(_ newSelectedItem: String?) {
        var newMarker: TripPoint?

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
