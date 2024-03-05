//
//  MapItemInfoView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/03/2024.
//

import SwiftUI
import MapKit

struct MapItemInfoView: View {

    var selectedItem: MKMapItem

    @State private var lookAroundScene: MKLookAroundScene?

    var body: some View {
        LookAroundPreview(initialScene: lookAroundScene)
            .overlay(alignment: .bottomTrailing) {
                HStack {
                    Text(selectedItem.name ?? "")
                }
                .font(.caption)
                .foregroundStyle(.white)
                .padding(10)
            }
            .onAppear {
                getLookAroundScene()
            }
            .onChange(of: selectedItem) {
                getLookAroundScene()
            }
    }

    // MARK: - Tools

    func getLookAroundScene() {
        lookAroundScene = nil
        Task {
            let request = MKLookAroundSceneRequest(mapItem: selectedItem)
            lookAroundScene = try await request.scene
        }
    }

//    var travelTime: String? {
//        guard let route else { return nil }
//        let formatter = DateComponentsFormatter()
//        formatter.allowedUnits = [.hour, .minute]
//        formatter.unitsStyle = .abbreviated
//        return formatter.string(from: route.expectedTravelTime)
//    }
}

#Preview {
    MapItemInfoView(selectedItem:
            .init(placemark: .init(coordinate: .giteDeLaColleStMichel))
    )
}
