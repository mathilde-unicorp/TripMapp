//
//  TripProjectsPicker.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 17/07/2024.
//

import SwiftUI

struct TripProjectsPicker: View {

    @Binding var selectedProject: TripProjectEntity?

    var mapItemToAdd: TripPoint?

    // -------------------------------------------------------------------------
    // MARK: - Private
    // -------------------------------------------------------------------------

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        fetchRequest: TripProjectEntity.sortedFetchRequest(),
        transaction: .init(animation: .default)
    )

    private var projects: FetchedResults<TripProjectEntity>

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        List(selection: $selectedProject) {
            Text("projects.select_to_add_point.description")
                .font(.caption)
                .listRowSeparator(.hidden)

            Section("projects") {
                ForEach(projects, id: \.self) { project in
                    projectRow(project)
                }
            }
        }
        .listStyle(.plain)
        .onAppear {
            self.selectedProject = nil
        }
    }

    @ViewBuilder
    private func projectRow(_ project: TripProjectEntity) -> some View {
        let isMapItemAlreadyAdded = isMapItemAlreadyAdded(in: project)

        VStack(alignment: .leading) {
            TripProjectRow(project: project)

            HStack {
                Text("markers_count \(project.points.count)")

                if isMapItemAlreadyAdded {
                    Text("marker_already_added")
                }
            }
            .font(.caption)
        }
        .selectionDisabled(isMapItemAlreadyAdded)
        .opacity(isMapItemAlreadyAdded ? 0.5 : 1.0)
    }

    // -------------------------------------------------------------------------
    // MARK: - Tools
    // -------------------------------------------------------------------------

    private func isMapItemAlreadyAdded(in project: TripProjectEntity) -> Bool {
        guard let mapItemToAdd else { return false }

        return project.contains(marker: mapItemToAdd)
    }
}

#Preview {
    TripProjectsPicker(
        selectedProject: .constant(nil),
        mapItemToAdd: .mocks.first!
    )
    .configureEnvironmentForPreview()
}
