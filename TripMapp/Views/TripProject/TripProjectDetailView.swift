//
//  ProjectDetailView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/04/2024.
//

import SwiftUI
import MapKit
import CoreData

struct TripProjectDetailView: View {

    // -------------------------------------------------------------------------
    // MARK: - Parameters
    // -------------------------------------------------------------------------

    @ObservedObject var projectEntity: TripProjectEntity

    // -------------------------------------------------------------------------
    // MARK: - Private
    // -------------------------------------------------------------------------

    @State private var editProject: Bool = false
    /// The local selected item id
    @State private var localSelectedItemId: String?
    /// The  region visible on the map
    @State private var visibleRegion: MKCoordinateRegion?

    /// The marker selected on the map
    @State private var selectedMarker: TripPoint?

    private var markers: [TripPoint] {
        projectEntity.points.map { TripPoint.build(from: $0) }
    }

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        TripMap(
            visibleRegion: $visibleRegion,
            selectedItem: $localSelectedItemId
        ) {
            MarkersLayer(markers: .constant(markers))
        }
        .mapControls {
            MapUserLocationButton()
        }
        .toolbar {
            ToolbarItem {
                Button("edit") { editProject.toggle() }
            }
        }
        .overlay(alignment: .topLeading) {
            TripLayersPanel(
                projectEntity: projectEntity,
                selectedItemId: $localSelectedItemId
            )
        }
        .overlay(alignment: .bottom) {
            TripPointInfoView(
                tripPoint: $selectedMarker,
                currentProject: projectEntity
            )
        }
        .onChange(of: localSelectedItemId) { _, newSelectedItem in
            self.onSelectedItemChanged(newSelectedItem)
        }
        .fullScreenCover(isPresented: $editProject) {
            NavigationStack {
                TripProjectInformationsView(projectEntity: projectEntity)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(projectEntity.name ?? "")
        .toolbarBackground(.visible, for: .navigationBar)
    }

    private func onSelectedItemChanged(_ newSelectedItem: String?) {
        var newMarker: TripPoint?

        if let markerId = newSelectedItem {
            newMarker = self.markers.first(keyPath: \.id, equals: markerId)
        } else {
            newMarker = nil
        }

        withAnimation {
            self.selectedMarker = newMarker
        }
    }
}

#Preview {
    NavigationStack {
        TripProjectDetailView(
            projectEntity: .previewExample
        )
        .configureEnvironmentForPreview()
    }
}
