//
//  HomeMapView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/04/2024.
//

import SwiftUI
import MapKit

struct HomeMapView: View {
    @State private var searchTripPointTypes: [TripPointType] = []
    @State private var selectedMarker: TripPoint?
    @State private var searchBarSize: SearchBarSize = .medium

    var body: some View {
        TripMapSearch(
            searchTripPointTypes: $searchTripPointTypes,
            selectedMarker: $selectedMarker,
            dataSource: .init(mapItemsRepository: .shared)
        )
        .tripMapSearchable(
            searchTripPointTypes: $searchTripPointTypes,
            selectedMapMarker: $selectedMarker,
            searchBarSize: $searchBarSize
        )
    }
}

#Preview {
    HomeMapView()
        .configureEnvironmentForPreview()
}
