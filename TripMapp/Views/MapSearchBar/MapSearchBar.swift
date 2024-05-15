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
            HStack {
                Image(systemName: "magnifyingglass")

                Text("map_search_bar.placeholder")
                    .setFullWidth()
            }
            .foregroundStyle(.secondary)
            .padding(8.0)
            .background(.thickMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 25.0))

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
