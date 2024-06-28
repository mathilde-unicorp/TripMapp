//
//  ProjectDetailView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/04/2024.
//

import SwiftUI
import MapKit

struct TripProjectDetailView: View {

    @State private var showSidebar: Bool = false
    @State private var editProject: Bool = false

    @ObservedObject var project: TripProjectEntity

    var body: some View {
        Map {
            Marker(coordinate: .cabaneClartan, label: {
                Label("_example_hello_world", image: "pin")
            })
        }
        .mapControls {
            MapUserLocationButton()
        }
        .overlay(alignment: .bottom) {
            MapSearchBar()
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
                TripProjectLayersView(
                    project: TripProject(name: project.name ?? ""),
                    isPresented: $showSidebar
                )
                .frame(width: 300)
            }
        }
        .toolbar {
            ToolbarItem {
                Button("edit") { editProject.toggle() }
            }
        }
        .fullScreenCover(isPresented: $editProject) {
            NavigationStack {
                TripProjectInformationsView(project: project)
            }
        }
        .navigationTitle(project.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        TripProjectDetailView(
            project: TripProjectEntity(
                context: .previewViewContext,
                name: "Test"
            )
        )
        .environment(\.managedObjectContext, .previewViewContext)
    }
}
