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

    /// List of user projects sorted by the one starting first then by name
    @FetchRequest(
        fetchRequest: TripProjectEntity.sortedFetchRequest(),
        transaction: .init(animation: .default)
    )
    private var projects: FetchedResults<TripProjectEntity>

    // -------------------------------------------------------------------------
    // MARK: - Private
    // -------------------------------------------------------------------------

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        List(selection: $selectedProject) {
            ForEach(projects) { project in
                NavigationLink(value: project) {
                    TripProjectRow(project: project)
                }
            }
            .onDelete { deleteItems(offsets: $0) }
        }
        .listStyle(.plain)
    }

    // -------------------------------------------------------------------------
    // MARK: - Actions
    // -------------------------------------------------------------------------

    private func deleteItems(offsets: IndexSet) {
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
