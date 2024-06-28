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
                TripProjectDetailView(project: project)
            } else {
                Text("project_selection_placeholder")
            }
        }
    }

    @ToolbarContentBuilder
    private func projectsToolbar() -> some ToolbarContent {
        ToolbarItem {
            Button("project.new", action: {
                let newProject = createNewProject()

                selectedProject = newProject
            })
        }
    }

    private func createNewProject() -> TripProjectEntity {
        withAnimation {
            let newItem = TripProjectEntity(
                context: viewContext,
                name: String(localized: "project.new")
            )

            do {
                try viewContext.save()

                return newItem
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

}

#Preview {
    HomeProjectsView()
        .environment(\.managedObjectContext, .previewViewContext)
}
