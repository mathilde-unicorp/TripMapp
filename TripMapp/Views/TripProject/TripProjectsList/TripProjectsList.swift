//
//  TripProjectsList.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 16/05/2024.
//

import SwiftUI

struct TripProjectsList: View {

    @Binding var selectedProject: TripProjectEntity?

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        fetchRequest: TripProjectEntity.sortedFetchRequest(),
        transaction: .init(animation: .default)
    )
    private var projects: FetchedResults<TripProjectEntity>

    var body: some View {
        List(selection: $selectedProject) {
            ForEach(projects) { project in
                NavigationLink(value: project, label: {
                    TripProjectRow(project: project)
                })
            }
            .onDelete { deleteItems(offsets: $0) }
        }
        .listStyle(.plain)
    }

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
