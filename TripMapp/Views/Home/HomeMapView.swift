//
//  HomeMapView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/04/2024.
//

import SwiftUI
import MapKit

struct HomeMapView: View {
    @State private var selectedPOITypes: [PointsOfInterestType] = []
    @State private var selectedMarker: TripMapMarker.ViewModel?

    var body: some View {
        MapSearchByPOITypeView(
            searchPOITypes: $selectedPOITypes,
            selectedMarker: $selectedMarker,
            dataSource: .init(mapItemsRepository: .shared)
        )
        .overlay(alignment: .bottom) {
            TripMapMarkerInfoView(selectedMarker: $selectedMarker)
        }
        .safeAreaInset(edge: .bottom) {
            MapSearchBar(selectedPOITypes: $selectedPOITypes)
                .background(.thinMaterial)
        }
    }
}

#Preview {
    HomeMapView()
        .environment(\.managedObjectContext, .previewViewContext)
}
