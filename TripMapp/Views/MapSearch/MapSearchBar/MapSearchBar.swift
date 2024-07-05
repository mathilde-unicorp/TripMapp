//
//  MapSearchBar.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/04/2024.
//

import SwiftUI
import MapKit

struct MapSearchBar: View {

    @Binding var selectedPOITypes: [POIType]

    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            SearchBarButton(placeholder: "map_search_bar.placeholder") {
                // open research
            }

            MapSearchPOITypeSection(selectedTypes: $selectedPOITypes)
        }
        .padding()
    }
}

struct MapSearchBar_Previews: PreviewProvider {

    struct ContainerView: View {
        @State private var selectedPOITypes: [POIType] = []

        var body: some View {
            MapSearchBar(selectedPOITypes: $selectedPOITypes)
                .background(.thinMaterial)
        }
    }

    static var previews: some View {
        ContainerView()
            .environment(\.managedObjectContext, .previewViewContext)
    }
}
