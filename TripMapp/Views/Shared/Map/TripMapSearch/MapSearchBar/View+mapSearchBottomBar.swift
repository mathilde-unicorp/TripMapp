//
//  View+MapSearchable.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/07/2024.
//

import SwiftUI
import MapKit

struct MapSearchBottomBarModifier: ViewModifier {

    @Binding var selectedTripPointTypes: [TripPointType]
    @Binding var searchBarSize: SearchBarSize
    @Binding var selectedMarker: TripPoint?

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                VStack {
                    TripPointCardView(
                        tripPoint: $selectedMarker,
                        currentProject: nil
                    )

                    MapSearchBar(
                        selectedTripPointTypes: $selectedTripPointTypes,
                        searchBarSize: $searchBarSize
                    )
                    .background(.thickMaterial)
                }
        }
        .onChange(of: selectedMarker) { _, newSelectedMarker in
            if newSelectedMarker != nil {
                withAnimation {
                    self.searchBarSize = .reduced
                }
            }
        }
    }
}

extension View {

    /// Add a search bar and an overview for markers selected on the map
    func mapSearchBottomBar(
        searchTripPointTypes: Binding<[TripPointType]>,
        selectedMapMarker: Binding<TripPoint?>,
        searchBarSize: Binding<SearchBarSize> = .constant(.medium)
    ) -> some View {
        self.modifier(
            MapSearchBottomBarModifier(
                selectedTripPointTypes: searchTripPointTypes,
                searchBarSize: searchBarSize,
                selectedMarker: selectedMapMarker
            )
        )
    }
}

#Preview {
    Map {

    }.mapSearchBottomBar(
        searchTripPointTypes: .constant([.refuge]),
        selectedMapMarker: .constant(nil),
        searchBarSize: .constant(.medium)
    )
}
