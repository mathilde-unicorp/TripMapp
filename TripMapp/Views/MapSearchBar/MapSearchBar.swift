//
//  MapSearchBar.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/04/2024.
//

import SwiftUI
import MapKit

struct MapSearchBar: View {

    @State private var selectedPOITypes: [POIType] = []

    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            SearchBarButton(placeholder: "map_search_bar.placeholder") {
                // open research
            }
            .padding(.vertical)

            MapSearchPOITypeSection(selectedTypes: $selectedPOITypes)
        }
        .padding()
    }
}

#Preview {
    MapSearchBar()
        .environment(
            \.managedObjectContext,
             PersistenceController.preview.container.viewContext
        )

}
