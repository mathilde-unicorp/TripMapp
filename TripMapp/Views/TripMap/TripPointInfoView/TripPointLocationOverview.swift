//
//  MKMapMarkerInfoView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/03/2024.
//

import SwiftUI
import MapKit

struct TripPointLocationOverview: View {

    @Binding var mapItem: TripPoint?

    @State var isLoadingLookAround: Bool = false
    @State private var lookAroundScene: MKLookAroundScene?

    var body: some View {
        VStack {
            if let lookAroundScene {
                LookAroundPreview(initialScene: lookAroundScene)
                    .frame(height: 128)
            }

            if isLoadingLookAround {
                Color.secondarySystemBackground
                    .frame(height: 128)
                    .overlay { ProgressView() }
            }
        }
        .onAppear {
            getLookAroundScene()
        }
        .onChange(of: mapItem) {
            getLookAroundScene()
        }
    }

    // MARK: - Requests

    func getLookAroundScene() {
        withAnimation {
            lookAroundScene = nil
        }

        guard let mapItem else { return }

        switch mapItem.source {
        case .refugesInfo, .custom:
            let coordinates = mapItem.coordinates
            let mapItem = MKMapItem(placemark: .init(coordinate: coordinates))
            getLookAroundScene(mkMapItem: mapItem)
        case .mkMap(let item):
            getLookAroundScene(mkMapItem: item)
        }
    }

    private func getLookAroundScene(mkMapItem: MKMapItem) {
        withAnimation { isLoadingLookAround = true }

        Task {
            let request = MKLookAroundSceneRequest(mapItem: mkMapItem)
            let scene = try? await request.scene

            DispatchQueue.main.async {
                withAnimation {
                    self.lookAroundScene = scene
                    self.isLoadingLookAround = false
                }
            }

        }
    }
}

#Preview {
    TripPointLocationOverview(mapItem: .constant(.mocks[1]))
}
