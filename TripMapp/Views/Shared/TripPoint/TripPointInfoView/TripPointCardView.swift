//
//  TripMapMarkerOverview.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/07/2024.
//

import SwiftUI

/// Display a bunch of informations about a TripPoint
struct TripPointCardView: View {
    
    // -------------------------------------------------------------------------
    // MARK: - Parameters
    // -------------------------------------------------------------------------
    
    /// The selected TripPoint presenting its informations
    @Binding var tripPoint: TripPoint?
    
    /// The project context
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
        TripPointCardView(
            tripPoint: .constant(.mocks.first!)
        )
        
        TripPointCardView(
            tripPoint: .constant(.mocks.first!),
            currentProject: .previewExample
        )
    }
    .configureEnvironmentForPreview()
}
