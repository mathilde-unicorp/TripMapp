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
        sortDescriptors: [SortDescriptor(\.name, order: .forward)],
        animation: .default
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
            offsets.map { projects[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                print("Got error on deleting objects \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

#Preview {
    NavigationStack {
        TripProjectsList(selectedProject: .constant(nil))
    }
    .environment(\.managedObjectContext, .previewViewContext)
}
