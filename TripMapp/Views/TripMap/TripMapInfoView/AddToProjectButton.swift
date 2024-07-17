//
//  AddToProjectButton.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 17/07/2024.
//

import SwiftUI

struct AddToProjectButton: View {

    enum AddingState {
        case idle
        case added
    }

    let mapItem: TripMapMarker.ViewModel

    @Environment(\.managedObjectContext) private var viewContext

    @State private var shouldOpenProjectPicker: Bool = false
    @State var selectedProject: TripProjectEntity?

    @State var addingState: AddingState = .idle

    private var labelStringKey: LocalizedStringKey {
        return addingState == .idle ? "add_to_project" : "added_to_project"
    }

    private var labelSystemImage: String {
        return addingState == .idle ? "plus" : "checkmark.circle.fill"
    }

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        Button(action: {
            shouldOpenProjectPicker = true
        }, label: {
            Label(labelStringKey, systemImage: labelSystemImage)
                .contentTransition(.symbolEffect(.replace.downUp))
        })
        .tint(addingState == .added ? .green : .accentColor)
        .sheet(isPresented: $shouldOpenProjectPicker) {
            NavigationStack {
                Label(mapItem.name, systemImage: mapItem.systemImage)
                    .font(.headline)
                    .padding()

                TripProjectsPicker(selectedProject: $selectedProject)
            }
        }
        .onChange(of: selectedProject) { _, project in
            if let project {
                shouldOpenProjectPicker = false
                addMapMarkerToProject(project)
                selectedProject = nil
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    self.addingState = .added
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.addingState = .idle
                }
            }
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Actions
    // -------------------------------------------------------------------------

    private func addMapMarkerToProject(_ project: TripProjectEntity) {
        TripPointEntity(context: viewContext)
            .setup(name: mapItem.name, type: mapItem.pointType)
            .setup(
                source: mapItem.source.tripPointSource,
                sourceId: mapItem.source.sourceId
            )
            .setupLocation(
                latitude: mapItem.coordinates.latitude,
                longitude: mapItem.coordinates.latitude
            )
            .addToProject(project)

        try? viewContext.save()
    }
}

#Preview {
    AddToProjectButton(mapItem: .mocks.first!)
        .buttonStyle(.borderedProminent)
        .configureEnvironmentForPreview()
}
