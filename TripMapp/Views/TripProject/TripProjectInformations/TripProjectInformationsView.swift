//
//  TripProjectCreateView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 15/05/2024.
//

import SwiftUI
import CoreData

struct TripProjectInformationsView: View {

    @ObservedObject private var projectEntity: TripProjectEntity

    // -------------------------------------------------------------------------
    // MARK: - Local items
    // -------------------------------------------------------------------------

    @ObservedObject private var localProject: TripProject

    @State var files: [ImportedFile] = [
        .init(url: URL(string: "local.url")!, name: "File 1"),
        .init(url: URL(string: "local.url")!, name: "File 2")
    ]

    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) private var dismiss

    // -------------------------------------------------------------------------
    // MARK: - Initialization
    // -------------------------------------------------------------------------

    init(projectEntity: TripProjectEntity) {
        self.projectEntity = projectEntity

        self.localProject = .init(entity: projectEntity)
    }

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        GeometryReader { proxy in
            Form {
                TripProjectNameAndImageSection(
                    name: $localProject.name,
                    imageHeight: proxy.size.height * 0.3
                )

                TripProjectImportFileSection(files: $files)

                TripProjectAdditionnalInformations(
                    startDate: $localProject.startDate,
                    endDate: $localProject.endDate,
                    notes: $localProject.notes
                )
            }
            .scrollDismissesKeyboard(.interactively)
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("save") { saveProject() }
            }

            ToolbarItem(placement: .cancellationAction) {
                Button("cancel") { dismiss() }
            }
        }
        .navigationTitle("project.edit")
    }

    // -------------------------------------------------------------------------
    // MARK: - Actions
    // -------------------------------------------------------------------------

    private func saveProject() {
        viewContext.update(entity: projectEntity, with: localProject)
        dismiss()
    }
}

#Preview {
    NavigationStack {
        TripProjectInformationsView(
            projectEntity: NSManagedObjectContext.previewViewContext
                .createTripProjectEntity(name: "Project 1")!
        )
        .configureEnvironmentForPreview()
    }
}
