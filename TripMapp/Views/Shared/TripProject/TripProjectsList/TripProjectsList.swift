//
//  TripProjectsList.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 16/05/2024.
//

import SwiftUI

/// List of users Trip Projects
struct TripProjectsList: View {

    // -------------------------------------------------------------------------
    // MARK: - Parameters
    // -------------------------------------------------------------------------

    /// Project selected on the TripProjects list
    @Binding var selectedProject: TripProjectEntity?

    // -------------------------------------------------------------------------
    // MARK: - Swift Data
    // -------------------------------------------------------------------------

    /// Local data access
    @Environment(\.managedObjectContext) private var viewContext

    // -------------------------------------------------------------------------
    // MARK: - Private
    // -------------------------------------------------------------------------

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        List(selection: $selectedProject) {
            LocalTripProjects { projects in
                ForEach(projects) { project in
                    NavigationLink(value: project) {
                        TripProjectRow(project: project)
                    }
                }
                .onDelete { deleteItems(from: projects, offsets: $0) }
            }
        }
        .listStyle(.plain)
    }

    // -------------------------------------------------------------------------
    // MARK: - Actions
    // -------------------------------------------------------------------------

    private func deleteItems(
        from projects: FetchedResults<TripProjectEntity>,
        offsets: IndexSet
    ) {
        withAnimation {
            offsets.map { projects[$0] }
                .forEach { viewContext.deleteTripProject($0) }

            try? viewContext.save()
        }
    }
}

#Preview {
    NavigationStack {
        TripProjectsList(selectedProject: .constant(nil))
    }
    .configureEnvironmentForPreview()
}
