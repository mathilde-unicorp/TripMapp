//
//  HomeProjectsView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/04/2024.
//

import SwiftUI

struct HomeProjectsView: View {

    @State private var selectedProject: TripProject?

    @State private var columnVisibility: NavigationSplitViewVisibility = .all

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
                TripProjectDetailView(project: project)
            } else {
                Text("project_selection_placeholder")
            }
        }
    }

    @ToolbarContentBuilder
    private func projectsToolbar() -> some ToolbarContent {
        ToolbarItem {
            NavigationLink {
                TripProjectDetailView(project: .init(name: "new"))
            } label: {
                Text("project.new")
            }
        }
    }
}

#Preview {
    HomeProjectsView()
}
