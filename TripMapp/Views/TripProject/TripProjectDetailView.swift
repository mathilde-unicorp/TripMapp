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
        ZStack(alignment: .topLeading) {
            Map {

            }
            .mapControls {
                MapUserLocationButton()
            }

            if !showSidebar {
                Button("Layers", systemImage: "sidebar.left") {
                    withAnimation { showSidebar = true }
                }
                .padding(8.0)
                .buttonStyle(.borderedProminent)
            } else {
                List {
                    Section("Layers") {
                        Label("Layer 1", systemImage: "arrow.triangle.swap")
                        Label("Layer 1", systemImage: "arrow.triangle.swap")
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("", systemImage: "sidebar.left") {
                            withAnimation { self.showSidebar = false }
                        }
                    }
                }
                .frame(width: 300)
            }
        }
        .toolbar {
            ToolbarItem {
                NavigationLink(destination: {
                    Text("Edit view")
                }, label: {
                    Label("Edit", systemImage: "pencil")
                })
            }
        }
        .navigationTitle(project.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        TripProjectDetailView(project: .init(name: "Test"))
    }
}
