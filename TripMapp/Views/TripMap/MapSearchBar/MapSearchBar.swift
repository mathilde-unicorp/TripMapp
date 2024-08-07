//
//  MapSearchBar.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/04/2024.
//

import SwiftUI
import MapKit

struct MapSearchBar: View {
    @Binding var selectedTripPointTypes: [TripPointType]

    @Binding var searchBarSize: SearchBarSize

    var body: some View {
        searchBarSized()
            .padding()
            .padding(.top, 8.0) // Let some padding for the search bar slider
            .overlay(alignment: .top) {
                MapSearchBarSizeSlider(searchBarSize: $searchBarSize)
            }
    }
}

// =============================================================================
// MARK: - Preview
// =============================================================================

struct MapSearchBar_Previews: PreviewProvider {

    struct ContainerView: View {
        @State private var selectedTripPointTypes: [TripPointType] = []
        @State private var searchBarSize: SearchBarSize = .medium

        var body: some View {
            MapSearchBar(
                selectedTripPointTypes: $selectedTripPointTypes,
                searchBarSize: $searchBarSize
            )
            .background(.thinMaterial)
        }
    }

    static var previews: some View {
        ContainerView()
            .configureEnvironmentForPreview()
    }
}
