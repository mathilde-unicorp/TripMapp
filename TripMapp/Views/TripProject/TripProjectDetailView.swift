//
//  ProjectDetailView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/04/2024.
//

import SwiftUI
import MapKit

struct TripProjectDetailView: View {

    let project: TripProject

    @State private var showSidebar: Bool = false

    var body: some View {
        Map {
            Marker(coordinate: .cabaneClartan, label: {
                Label("_example_hello_world", image: "pin")
            })
        }
        .mapControls {
            MapUserLocationButton()
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
                    project: project,
                    isPresented: $showSidebar
                )
                .frame(width: 300)
            }
        }
        .toolbar {
            ToolbarItem {
                NavigationLink(destination: {
                    TripProjectEditView(project: project)
                }, label: {
                    Label("edit", systemImage: "pencil")
                })
            }
        }
        .navigationTitle(project.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        TripProjectDetailView(project: .init(name: "Test", markers: [], traces: [], layers: []))
    }
}
