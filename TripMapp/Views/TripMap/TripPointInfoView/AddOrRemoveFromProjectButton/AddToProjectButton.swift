//
//  AddToProjectButton.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 17/07/2024.
//

import SwiftUI

struct AddToProjectButton: View {

    /// Item to add in a project
    let tripPoint: TripPoint

    @Environment(\.managedObjectContext) private var viewContext

    // -------------------------------------------------------------------------
    // MARK: - Private
    // -------------------------------------------------------------------------

    /// Project selected to add the `mapItem` into. If nil, present a sheet to select a project
    @State private var selectedProject: TripProjectEntity?
    /// Animation state of the "adding to project" action
    @State private var addingAnimationState: AnimationState = .idle
    /// Should open the project picker sheet to select the project where we want to add the `mapItem`
    @State private var shouldOpenProjectPicker: Bool = false

    private var labelStringKey: LocalizedStringKey {
        switch addingAnimationState {
        case .idle: addToProjectString
        case .success: "added_to_project"
        case .error: "error"
        }
    }

    private var labelSystemImage: String {
        switch addingAnimationState {
        case .idle: "plus"
        case .success: "checkmark.circle.fill"
        case .error: "xmark.circle.fill"
        }
    }

    private var addToProjectString: LocalizedStringKey {
        if let selectedProjectName = selectedProject?.name {
            "add_to_project \(selectedProjectName)"
        } else {
            "add_to_project"
        }
    }

    private var buttonTintColor: Color {
        switch addingAnimationState {
        case .idle: .accentColor
        case .success: .green
        case .error: .red
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        Button(action: onTapButton) {
            Label(labelStringKey, systemImage: labelSystemImage)
                .contentTransition(.symbolEffect(.replace.downUp))
        }
        .tint(buttonTintColor)
        .animation(.smooth, value: addingAnimationState)
        .playSound(
            isPlaying: .constant(addingAnimationState == .success),
            sound: .workoutSavedHaptic
        )
        .resetToIdle($addingAnimationState, after: 2.5)
        .sheet(isPresented: $shouldOpenProjectPicker) {
            projectPickerSheet()
        }
        .onChange(of: selectedProject) { _, project in
            onChange(selectedProject: project)
        }
    }

    @ViewBuilder
    private func projectPickerSheet() -> some View {
        NavigationStack {
            Label(tripPoint.name, systemImage: tripPoint.systemImage)
                .font(.headline)
                .padding()

            TripProjectsPicker(
                selectedProject: $selectedProject,
                tripPointToAdd: tripPoint
            )
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Actions
    // -------------------------------------------------------------------------

    private func onTapButton() {
        if let selectedProject {
            addMapMarker(to: selectedProject)
            playAddSucceedAnimation()
        } else {
            shouldOpenProjectPicker = true
        }
    }

    private func onChange(selectedProject project: TripProjectEntity?) {
        if let project {
            shouldOpenProjectPicker = false
            addMapMarker(to: project)
            selectedProject = nil
        }

        playAddSucceedAnimation()
    }

    // -------------------------------------------------------------------------
    // MARK: - Data
    // -------------------------------------------------------------------------

    private func addMapMarker(to project: TripProjectEntity) {
        TripPointEntity(context: viewContext)
            .setup(name: tripPoint.name, type: tripPoint.pointType)
            .setup(source: tripPoint.source, sourceId: tripPoint.sourceId)
            .setupLocation(coordinates: tripPoint.coordinates)
            .update(position: (project.points.last?.position ?? 0) + 1)
            .addToProject(project)

        try? viewContext.save()
    }

    // -------------------------------------------------------------------------
    // MARK: - Animations
    // -------------------------------------------------------------------------

    private func playAddSucceedAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.addingAnimationState = .success
        }
    }
}

#Preview {
    VStack {
        AddToProjectButton(tripPoint: .mocks.first!)
    }
    .buttonStyle(.borderedProminent)
    .configureEnvironmentForPreview()
}
