//
//  TripProjectCreateView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/05/2024.
//

import SwiftUI

struct TripProjectInformationsView: View {

    @State var project: TripProject

    @ObservedObject private var viewModel: TripProjectInformationsViewModel

    @Environment(\.dismiss) private var dismiss

    init(project: TripProject) {
        self.project = project

        self.viewModel = .init(
            name: project.name,
            files: [],
            startDate: project.startDate?.formatted() ?? "",
            endDate: project.endDate?.formatted() ?? "",
            notes: project.notes
        )
    }

    var body: some View {
        GeometryReader { proxy in
            Form {
                TripProjectNameAndImageSection(
                    name: $project.name,
                    imageHeight: proxy.size.height * 0.3
                )

                TripProjectImportFileSection(files: $viewModel.files)

                TripProjectAdditionnalInformations(
                    startDate: $viewModel.startDate,
                    endDate: $viewModel.endDate,
                    notes: $viewModel.notes
                )
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("save") {}
            }

            ToolbarItem(placement: .cancellationAction) {
                Button("cancel") { dismiss() }
            }
        }
        .navigationTitle("project.edit")
    }
}

#Preview {
    NavigationStack {
        TripProjectInformationsView(project: TripProject(name: ""))
    }
}
