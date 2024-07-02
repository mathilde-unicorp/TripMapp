//
//  RefreshMapButton.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 02/07/2024.
//

import SwiftUI

struct RefreshMapButton: View {
    var action: () -> Void

    var body: some View {
        Button(action: action, label: {
            Label("refresh_here", systemImage: "arrow.clockwise")
        })
        .buttonStyle(.bordered)
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
        .padding(10.0)
    }
}

#Preview {
    RefreshMapButton { print("refresh") }
}
