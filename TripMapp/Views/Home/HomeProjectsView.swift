//
//  HomeProjectsView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/04/2024.
//

import SwiftUI

struct HomeProjectsView: View {

    @State private var projects = [
        TripProject(name: "Project 1"),
        TripProject(name: "Project 2"),
        TripProject(name: "Project 3"),
        TripProject(name: "Project 4")
    ]

    @State private var selectedProject: TripProject?

    @State private var columnVisibility: NavigationSplitViewVisibility = .all

    var body: some View {
        NavigationSplitView(
            columnVisibility: $columnVisibility
        ) {
            List(projects, selection: $selectedProject) {
                NavigationLink($0.name, value: $0)
            }
            .navigationTitle("Projects")
        } detail: {
            if let project = selectedProject {
                TripProjectDetailView(project: project)
            } else {
                Text("Select a project")
            }
        }
    }
}

#Preview {
    HomeProjectsView()
}
