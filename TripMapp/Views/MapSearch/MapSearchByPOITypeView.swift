//
//  MapSearchContent.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 03/07/2024.
//

import SwiftUI
import MapKit

struct MapSearchByPOITypeView: View {

    private let mapItemsRepository: TripMapItemsRepository = .init()

    @Binding var searchPOITypes: [POIType]

    @State private var searchOnRegion: MKCoordinateRegion?
    @State private var searchResults: [TripMapMarker.ViewModel] = []
    @State private var selectedItem: String?

    var body: some View {
        SearchableMap(
            searchOnRegion: $searchOnRegion,
            selectedItem: $selectedItem,
            onRefreshResult: {

            }, mapContent: {
                MarkersLayer(markers: $searchResults)
            })
    }
}

#Preview {
    MapSearchByPOITypeView(
        searchPOITypes: .constant([.refuge, .foodstuffProvisions])
    )
}
