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
                switch selectedMarker.source {
                case .mkMap:
                    MKMapMarkerInfoView(mapItem: selectedMarker)
                case .refugesInfo, .custom:
                    DefaultMapMarkerInfoView(mapItem: selectedMarker)
                        .padding()
                }
            }
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
        }
    }
}

#Preview {
    TripMapMarkerInfoView(selectedMarker: .constant(.mocks.first!))
}
