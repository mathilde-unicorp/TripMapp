//
//  TripMapMarkerOverview.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/07/2024.
//

import SwiftUI

struct TripMapMarkerInfoView: View {
    @Binding var selectedMarker: TripMapMarker.ViewModel?

    var body: some View {
        if let selectedMarker {
            VStack {
                TripMapMarkerLocationOverview(mapItem: $selectedMarker)

                TripMapMarkerInfoOverview(mapItem: selectedMarker)
                    .padding()
            }
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .overlay(alignment: .topTrailing) {
                Button("", systemImage: "xmark.circle.fill") {
                    withAnimation { self.selectedMarker = nil }
                }
                .foregroundStyle(.secondary)
                .shadow(color: .systemBackground, radius: 5)
                .padding(.top, 8.0)
            }
            .padding()
        }
    }
}

#Preview {
    TripMapMarkerInfoView(selectedMarker: .constant(.mocks.first!))
        .configureEnvironmentForPreview()
}
