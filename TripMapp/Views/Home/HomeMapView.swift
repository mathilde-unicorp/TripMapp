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

    var body: some View {
        MapSearchByPOITypeView(
            searchPOITypes: $selectedPOITypes,
            dataSource: .init(mapItemsRepository: .mock)
        )
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
