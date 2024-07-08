//
//  HomeProjectsView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/04/2024.
//

import SwiftUI

struct HomeProjectsView: View {

    @State private var selectedProject: TripProjectEntity?

    @State private var columnVisibility: NavigationSplitViewVisibility = .all

    @Environment(\.managedObjectContext) var viewContext

    var body: some View {
        NavigationSplitView(
            columnVisibility: $columnVisibility
        ) {
            TripProjectsList(selectedProject: $selectedProject)
                .navigationTitle("projects")
                .toolbar {
                    projectsToolbar()
                }
        } detail: {
            if let project = selectedProject {
                TripProjectDetailView(projectEntity: project)
            } else {
                Text("project_selection_placeholder")
            }
        }
    }

    @ToolbarContentBuilder
    private func projectsToolbar() -> some ToolbarContent {
        ToolbarItem {
            Button("project.new", action: {
                selectedProject = createNewProject()
            })
        }
    }

    private func createNewProject() -> TripProjectEntity? {
        withAnimation {
            return viewContext.createTripProjectEntity(
                name: String(localized: "project.new")
            )
        }
    }

}

#Preview {
    HomeProjectsView()
        .configureEnvironmentForPreview()
}
