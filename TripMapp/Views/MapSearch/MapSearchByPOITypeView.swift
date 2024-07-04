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

    @ObservedObject var dataSource: MapSearchByPOITypeDataSource

    @State private var selectedItem: String?
    @State private var searchOnRegion: MKCoordinateRegion?
    @State private var shouldShowRefreshButton: Bool = false

    // -------------------------------------------------------------------------
    // MARK: - Init
    // -------------------------------------------------------------------------

    init(
        searchPOITypes: Binding<[POIType]>,
        dataSource: MapSearchByPOITypeDataSource = .init(mapItemsRepository: .shared)
    ) {
        self._searchPOITypes = searchPOITypes
        self.dataSource = dataSource
    }

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        TripMap(
            visibleRegion: $searchOnRegion,
            selectedItem: $selectedItem
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
    }

    // -------------------------------------------------------------------------
    // MARK: - Actions
    // -------------------------------------------------------------------------

    private func refreshMapResults() {
        withAnimation {
            self.shouldShowRefreshButton = false

            self.dataSource.searchMapItems(
                ofTypes: searchPOITypes,
                on: searchOnRegion
            )
        }
    }
}

#Preview {
    MapSearchByPOITypeView(
        searchPOITypes: .constant([.refuge, .foodstuffProvisions]),
        dataSource: .init(mapItemsRepository: .mock)
    )
}
