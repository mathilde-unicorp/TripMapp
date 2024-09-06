//
//  LayersButton.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/05/2024.
//

import SwiftUI

struct LayersButton: View {

    let action: () -> Void

    var body: some View {
        Button("layers.button", systemImage: "sidebar.left", action: action)
            .padding(8.0)
    }
}

#Preview {
    LayersButton {
        print("show layers")
    }
}
