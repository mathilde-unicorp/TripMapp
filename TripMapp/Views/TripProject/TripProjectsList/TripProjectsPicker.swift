//
//  TripProjectsPicker.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 17/07/2024.
//

import SwiftUI

struct TripProjectsPicker: View {

    @Binding var selectedProject: TripProjectEntity?

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        fetchRequest: TripProjectEntity.sortedFetchRequest(),
        transaction: .init(animation: .default)
    )
    private var projects: FetchedResults<TripProjectEntity>

    var body: some View {
        List(selection: $selectedProject) {
            Text("projects.select_to_add_point.description")
                .font(.caption)
                .listRowSeparator(.hidden)

            Section("projects") {
                ForEach(projects, id: \.self) { project in
                    TripProjectRow(project: project)
                }
            }
        }
        .listStyle(.plain)
        .onAppear {
            self.selectedProject = nil
        }
    }
}

#Preview {
    TripProjectsPicker(selectedProject: .constant(nil))
        .configureEnvironmentForPreview()
}
