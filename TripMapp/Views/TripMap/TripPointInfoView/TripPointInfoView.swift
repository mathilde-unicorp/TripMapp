//
//  TripMapMarkerOverview.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/07/2024.
//

import SwiftUI

struct TripPointInfoView: View {
    @Binding var selectedMarker: TripPoint?

    var body: some View {
        if let selectedMarker {
            VStack {
                TripPointLocationOverview(mapItem: $selectedMarker)

                TripPointInfoOverview(
                    tripPoint: selectedMarker,
                    currentProject: nil
                )
                .padding()
            }
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .overlay(alignment: .topTrailing) {
                closeButton()
            }
            .padding()
        }
    }

    @ViewBuilder
    private func closeButton() -> some View {
        Button("", systemImage: "xmark.circle.fill") {
            withAnimation { self.selectedMarker = nil }
        }
        .foregroundStyle(.secondary)
        .shadow(color: .systemBackground, radius: 5)
        .padding(.top, 8.0)
    }
}

#Preview {
    TripPointInfoView(selectedMarker: .constant(.mocks.first!))
        .configureEnvironmentForPreview()
}
