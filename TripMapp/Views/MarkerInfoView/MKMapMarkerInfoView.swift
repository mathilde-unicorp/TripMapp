//
//  MKMapMarkerInfoView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/03/2024.
//

import SwiftUI
import MapKit

struct MKMapMarkerInfoView: View {

    var mapItem: TripMapMarker.ViewModel

    @State private var lookAroundScene: MKLookAroundScene?

    var body: some View {
        LookAroundPreview(initialScene: lookAroundScene)
            .frame(height: 128)
            .overlay(alignment: .bottomTrailing) {
                HStack {
                    Text(mapItem.name)
                }
                .font(.caption)
                .foregroundStyle(.white)
                .padding(10)
            }
            .onAppear {
                getLookAroundScene()
            }
            .onChange(of: mapItem) {
                getLookAroundScene()
            }
    }

    // MARK: - Tools

    func getLookAroundScene() {
        lookAroundScene = nil

        guard case .mkMap(let mkMapItem) = mapItem.source else { return }

        Task {
            let request = MKLookAroundSceneRequest(mapItem: mkMapItem)
            lookAroundScene = try await request.scene
        }
    }
}

#Preview {
    MKMapMarkerInfoView(mapItem: .init(
        mkMapItem: .init(placemark: .init(coordinate: .giteDeLaColleStMichel)),
        type: .cottage
    ))
}
