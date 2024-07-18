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

    @State private var showSidebar: Bool = false
    @State private var editProject: Bool = false

    @ObservedObject var projectEntity: TripProjectEntity

//    private var markers: [TripPoint] {
//        projectEntity.points.map(<#T##transform: (TripPointEntity) throws -> T##(TripPointEntity) throws -> T#>)
//    }

    var body: some View {
        Map {
            ForEach(projectEntity.points, id: \.self) { point in
                Marker(coordinate: CLLocationCoordinate2D(
                    latitude: point.latitude,
                    longitude: point.longitude
                ), label: {
                    Label(point.name ?? "", systemImage: "mappin")
                })
            }
        }
        .mapControls {
            MapUserLocationButton()
        }
        .overlay(alignment: .bottom) {
            MapSearchBar(
                selectedTripPointTypes: .constant([]),
                searchBarSize: .constant(.medium)
            )
            .setFullWidth()
            .background(.thinMaterial)
        }
        .overlay(alignment: .topLeading) {
            if !showSidebar {
                LayersButton {
                    withAnimation { showSidebar = true }
                }
                .background(.thickMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 6.0))
                .shadow(radius: 4)
                .padding(8.0)
            } else {
                HStack(spacing: 0) {
                    TripProjectLayersView(
                        isPresented: $showSidebar,
                        project: projectEntity
                    )
                    .frame(width: 300)

                    // TODO: only on small portrait mode
                    UIColor.systemBackground.withAlphaComponent(0.4).swiftUiColor
                        .onTapGesture {
                            withAnimation { showSidebar = false }
                        }
                }
            }
        }
        .toolbar {
            ToolbarItem {
                Button("edit") { editProject.toggle() }
            }
        }
        .fullScreenCover(isPresented: $editProject) {
            NavigationStack {
                TripProjectInformationsView(projectEntity: projectEntity)
            }
        }
        .navigationTitle(projectEntity.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
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
