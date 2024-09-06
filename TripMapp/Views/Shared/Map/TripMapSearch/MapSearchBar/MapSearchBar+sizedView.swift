//
//  MapSearchBarSized.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/07/2024.
//

import SwiftUI

extension MapSearchBar {

    private var seachBarPlaceholder: LocalizedStringKey {
        switch searchBarSize {
        case .medium: return "map_search_bar.placeholder"
        case .reduced: return "map_search_bar.short_placeholder"
        }
    }

    @ViewBuilder
    func searchBarSized() -> some View {
        VStack(alignment: .leading, spacing: 16.0) {
            HStack {
                SearchBarButton(placeholder: seachBarPlaceholder) {
                    // open research
                }

                // this organization seems a bit repetitive but it's the only way I found to keep the animation of the search bar between the two sizes
                if searchBarSize == .reduced {
                    TripPointTypesSection(
                        selectedTypes: $selectedTripPointTypes,
                        sectionSize: searchBarSize
                    )
                }
            }

            if searchBarSize == .medium {
                TripPointTypesSection(
                    selectedTypes: $selectedTripPointTypes,
                    sectionSize: searchBarSize
                )
            }
        }
    }
}

#Preview {
    VStack {
        MapSearchBar(
            selectedTripPointTypes: .constant([]),
            searchBarSize: .constant(.medium)
        )
        .padding()

        Divider()

        MapSearchBar(
            selectedTripPointTypes: .constant([]),
            searchBarSize: .constant(.reduced)
        )
        .padding()
    }
    .background(Color.secondarySystemBackground)
    .configureEnvironmentForPreview()
}
