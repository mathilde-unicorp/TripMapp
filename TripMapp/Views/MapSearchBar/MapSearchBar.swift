//
//  MapSearchBar.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/04/2024.
//

import SwiftUI
import MapKit

struct MapSearchBar: View {

    @State var searchText: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            SearchBarButton(placeholder: "map_search_bar.placeholder") {
                // open research
            }

            HStack {
                VStack {
                    Button(
                        "points_of_interest.refuge",
                        systemImage: "house.fill",
                        action: {}
                    )
                    .buttonStyle(BorderedProminentButtonStyle())
                    .foregroundStyle(.white)
                }

                Button(
                    "points_of_interest.refuge",
                    systemImage: "house.fill",
                    action: {}
                )
            }
        }
        .padding()
        .setFullWidth()
    }
}

#Preview {
    MapSearchBar()
}
