//
//  TripProjectCreateView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/05/2024.
//

import SwiftUI

struct TripProjectInformationsView: View {

    @ObservedObject var project: TripProjectEntity

    @ObservedObject private var viewModel: TripProjectInformationsViewModel

    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) private var dismiss

    init(project: TripProjectEntity) {
        self.project = project

        self.viewModel = .init(
            name: project.name ?? "",
            files: [],
            startDate: project.startDate?.formatted() ?? "",
            endDate: project.endDate?.formatted() ?? "",
            notes: project.notes ?? ""
        )
    }

    var body: some View {
        GeometryReader { proxy in
            Form {
                TripProjectNameAndImageSection(
                    name: $viewModel.name,
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
                Button("save") {
                    do {
                        let formatter = DateFormatter()
                        project.name = viewModel.name
                        project.startDate = formatter.date(from: viewModel.startDate)
                        project.endDate = formatter.date(from: viewModel.endDate)
                        project.notes = viewModel.notes

                        try viewContext.save()
                        dismiss()
                    } catch {
                        let nsError = error as NSError
                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")

                    }
                }
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
        TripProjectInformationsView(project: TripProjectEntity(
            context: PersistenceController.preview.container.viewContext,
            name: "Nouveau projet"
        ))
        .environment(
            \.managedObjectContext,
             PersistenceController.preview.container.viewContext
        )
    }
}
