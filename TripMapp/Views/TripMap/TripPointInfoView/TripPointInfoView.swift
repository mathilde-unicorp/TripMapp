//
//  TripMapMarkerOverview.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/07/2024.
//

import SwiftUI

/// Display a bunch of informations about a TripPoint
struct TripPointInfoView: View {

    /// The selected TripPoint presenting its informations
    @Binding var tripPoint: TripPoint?

    /// If the TripPoint is displayed within a Project context, it's set here
    var currentProject: TripProjectEntity?

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        if let tripPoint {
            VStack {
                TripPointLocationOverview(tripPoint: $tripPoint)

                TripPointDescriptionOverview(
                    tripPoint: tripPoint,
                    currentProject: currentProject
                )
                .padding()
            }
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .shadow(radius: 8)
            .overlay(alignment: .topTrailing) {
                closeButton()
            }
            .padding()
        }
    }

    @ViewBuilder
    private func closeButton() -> some View {
        Button("", systemImage: "xmark.circle.fill") {
            withAnimation { self.tripPoint = nil }
        }
        .foregroundStyle(.secondary)
        .shadow(color: .systemBackground, radius: 5)
        .padding(.top, 8.0)
    }
}

#Preview {
    VStack {
        TripPointInfoView(
            tripPoint: .constant(.mocks.first!)
        )

        TripPointInfoView(
            tripPoint: .constant(.mocks.first!),
            currentProject: .previewExample
        )
    }
        .configureEnvironmentForPreview()
}
