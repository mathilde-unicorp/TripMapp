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

struct RefreshMapButtonModifier: ViewModifier {

    @Binding var shouldShowRefreshButton: Bool

    var onRefresh: () -> Void

    func body(content: Content) -> some View {
        content.overlay(alignment: .top) {
            if shouldShowRefreshButton {
                RefreshMapButton(action: onRefresh)
            }
        }
    }
}

extension View {
    func mapRefreshable(isVisible: Binding<Bool>, onRefresh: @escaping () -> Void) -> some View {
        self.modifier(RefreshMapButtonModifier(
            shouldShowRefreshButton: isVisible,
            onRefresh: onRefresh
        ))
    }
}

#Preview {
    RefreshMapButton { print("refresh") }
}
