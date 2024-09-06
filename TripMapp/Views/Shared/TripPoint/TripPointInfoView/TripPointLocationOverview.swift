//
//  MKMapMarkerInfoView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/03/2024.
//

import SwiftUI
import MapKit

/// Display a location overview of the given tripPoint item
struct TripPointLocationOverview: View {

    // -------------------------------------------------------------------------
    // MARK: - Parameters
    // -------------------------------------------------------------------------

    /// Selected Trip Point  we want to display the location overview
    @Binding var tripPoint: TripPoint?

    // -------------------------------------------------------------------------
    // MARK: - Private
    // -------------------------------------------------------------------------

    @State private var isLoadingLookAround: Bool = false
    @State private var lookAroundScene: MKLookAroundScene?

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

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
        .onChange(of: tripPoint) {
            getLookAroundScene()
        }
    }

    // MARK: - Requests

    private func getLookAroundScene() {
        withAnimation {
            lookAroundScene = nil
        }

        guard let tripPoint else { return }

        getLookAroundScene(coordinate: tripPoint.coordinates)
    }

    private func getLookAroundScene(coordinate: CLLocationCoordinate2D) {
        guard isLoadingLookAround == false else { return }

        withAnimation { isLoadingLookAround = true }

        Task {
            let request = MKLookAroundSceneRequest(coordinate: coordinate)
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
    TripPointLocationOverview(tripPoint: .constant(.mocks[1]))
}
