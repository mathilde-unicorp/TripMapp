//
//  TripProjectsPicker.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 17/07/2024.
//

import SwiftUI

/// A Picker with user TripProjects list
/// It allows to specify a `tripPoint` that disable a project if it's already contained in it
struct TripProjectsPicker: View {

    // -------------------------------------------------------------------------
    // MARK: - Parameters
    // -------------------------------------------------------------------------

    /// User project selection in the picker
    @Binding var selectedProject: TripProjectEntity?

    /// A trip point the user want to add in a project
    let tripPointToAdd: TripPoint?

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        List(selection: $selectedProject) {
            Text("projects.select_to_add_point.description")
                .font(.caption)
                .listRowSeparator(.hidden)

            Section("projects") {
                LocalTripProjects { projects in
                    ForEach(projects, id: \.self) { project in
                        TripProjectRow(project: project)
                            .withPointsDetails(checkTripPointIncluded: tripPointToAdd)
                    }
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
    TripProjectsPicker(
        selectedProject: .constant(nil),
        tripPointToAdd: .mocks.first!
    )
    .configureEnvironmentForPreview()
}
