//
//  HomeMapView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/04/2024.
//

import SwiftUI
import MapKit

struct HomeMapView: View {
    @State private var searchPOITypes: [PointsOfInterestType] = []
    @State private var selectedMarker: TripMapMarker.ViewModel?
    @State private var searchBarSize: SearchBarSize = .medium

    var body: some View {
        MapSearchByPOITypeView(
            searchPOITypes: $searchPOITypes,
            selectedMarker: $selectedMarker,
            dataSource: .init(mapItemsRepository: .shared)
        )
        .tripMapSearchable(
            searchPOITypes: $searchPOITypes,
            selectedMapMarker: $selectedMarker,
            searchBarSize: $searchBarSize
        )
    }
}

#Preview {
    HomeMapView()
        .configureEnvironmentForPreview()
}
