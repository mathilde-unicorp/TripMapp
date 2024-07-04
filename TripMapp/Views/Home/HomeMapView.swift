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
        .safeAreaInset(edge: .bottom) {
            VStack {
                TestView(selectedMarker: $selectedMarker)

                MapSearchBar(selectedPOITypes: $selectedPOITypes)
            }
            .background(.thinMaterial)
        }
    }
}

struct TestView: View {
    @Binding var selectedMarker: TripMapMarker.ViewModel?

    var body: some View {
        if let selectedMarker {
            switch selectedMarker.source {
            case .refugesInfo:
                MapMarkerInfoView(mapItem: selectedMarker)
            case .mkMap:
                MKMapMarkerInfoView(mapItem: selectedMarker)
            case .custom:
                EmptyView()
            }
        }
    }
}

#Preview {
    HomeMapView()
        .environment(\.managedObjectContext, .previewViewContext)
}
