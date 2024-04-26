//
//  TripProjectEditView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/04/2024.
//

import SwiftUI
import MapKit

struct TripProjectEditView: View {

    let project: TripProject

    var body: some View {
        Map {

        }
        .safeAreaInset(edge: .bottom) {
            MapSearchBar()
                .setFullWidth()
                .background(.thinMaterial)

        }
        .navigationTitle(project.name)
    }
}

#Preview {
    TripProjectEditView(project: .init(
        name: "Projet",
        markers: [],
        traces: [],
        layers: [
            .init(name: "Layer 1", items: [])
        ]
    ))
}
