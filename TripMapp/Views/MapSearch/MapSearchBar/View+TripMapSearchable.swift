//
//  View+MapSearchable.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/07/2024.
//

import SwiftUI
import MapKit

struct MapSearchableModifier: ViewModifier {

    @Binding var selectedPOITypes: [PointsOfInterestType]
    @Binding var searchBarSize: SearchBarSize
    @Binding var selectedMarker: TripMapMarker.ViewModel?

    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                VStack {
                    TripMapMarkerInfoView(selectedMarker: $selectedMarker)

                    MapSearchBar(
                        selectedPOITypes: $selectedPOITypes,
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
    func tripMapSearchable(
        searchPOITypes: Binding<[PointsOfInterestType]>,
        selectedMapMarker: Binding<TripMapMarker.ViewModel?>,
        searchBarSize: Binding<SearchBarSize> = .constant(.medium)
    ) -> some View {
        self.modifier(MapSearchableModifier(
            selectedPOITypes: searchPOITypes,
            searchBarSize: searchBarSize,
            selectedMarker: selectedMapMarker
        ))
    }
}

#Preview {
    Map {

    }.tripMapSearchable(
        searchPOITypes: .constant([.refuge]),
        selectedMapMarker: .constant(nil),
        searchBarSize: .constant(.medium)
    )
}
