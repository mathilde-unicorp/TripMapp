//
//  MapButton.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 19/02/2024.
//

import SwiftUI

struct MapSearchButton: View {
    let action: () -> Void

    var body: some View {
        Button(
            action: action,
            label: { 
                Label("Relancer la recherche",
                      systemImage: "arrow.clockwise")
            })
            .buttonStyle(.borderless)
            .borderShadow()
    }
}

#Preview {
    MapSearchButton(action: {})
}
