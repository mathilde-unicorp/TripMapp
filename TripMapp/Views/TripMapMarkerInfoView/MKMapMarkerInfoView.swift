//
//  MKMapMarkerInfoView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/03/2024.
//

import SwiftUI
import MapKit

struct MKMapMarkerInfoView: View {

    var mapItem: MKMapItem

    @State private var lookAroundScene: MKLookAroundScene?

    var body: some View {
        LookAroundPreview(initialScene: lookAroundScene)
            .frame(height: 128)
            .overlay(alignment: .bottomTrailing) {
                HStack {
                    Text(mapItem.name ?? "")
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

        Task {
            let request = MKLookAroundSceneRequest(mapItem: mapItem)
            lookAroundScene = try await request.scene
        }
    }
}

#Preview {
    MKMapMarkerInfoView(mapItem: .init(
        placemark: .init(coordinate: .giteDeLaColleStMichel)
    ))
}
