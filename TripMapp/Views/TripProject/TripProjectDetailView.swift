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

    @ObservedObject var projectEntity: TripProjectEntity

    // -------------------------------------------------------------------------
    // MARK: - Private
    // -------------------------------------------------------------------------

    @State private var editProject: Bool = false
    /// The local selected item id
    @State private var localSelectedItem: String?
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
            selectedItem: $localSelectedItem
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
            TripLayersPanel(projectEntity: projectEntity)
        }
        .overlay(alignment: .bottom) {
            VStack {
                TripPointInfoView(
                    tripPoint: $selectedMarker,
                    currentProject: projectEntity
                )
            }
        }
        .onChange(of: localSelectedItem) { _, newSelectedItem in
            self.onSelectedItemChanged(newSelectedItem)
        }
        .fullScreenCover(isPresented: $editProject) {
            NavigationStack {
                TripProjectInformationsView(projectEntity: projectEntity)
            }
        }
        .navigationTitle(projectEntity.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
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
