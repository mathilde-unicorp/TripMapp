//
//  AddOrRemoveFromProjectButton.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 03/09/2024.
//

import SwiftUI

/// Dynamic Button to add or remove a tripPoint from a TripProject, depending on if it's already added or not
struct AddOrRemoveFromProjectButton: View {

    // -------------------------------------------------------------------------
    // MARK: - Parameters
    // -------------------------------------------------------------------------

    /// Trip Point to add or remove from the project
    let tripPoint: TripPoint

    /// Project selected to add the `mapItem` into. If nil, present a sheet to select a project
    @ObservedObject var selectedProject: TripProjectEntity

    // -------------------------------------------------------------------------
    // MARK: - Swift Data
    // -------------------------------------------------------------------------

    /// Local data access
    @Environment(\.managedObjectContext) private var viewContext

    // -------------------------------------------------------------------------
    // MARK: - Private
    // -------------------------------------------------------------------------

    /// Animation state of the "adding to project" action
    @State private var animation: AnimationState = .idle

    /// Should open the project picker sheet to select the project where we want to add the `mapItem`
    @State private var shouldOpenProjectPicker: Bool = false

    private var mapItemIsIncluded: Bool {
        selectedProject.contains(marker: tripPoint)
    }

    private var labelStringKey: LocalizedStringKey {
        switch animation {
        case .idle: mapItemIsIncluded ? removeFromProjectString : addToProjectString
        case .success: mapItemIsIncluded ? "added_to_project" : "removed_from_project"
        case .error: "error"
        }
    }

    private var labelSystemImage: String {
        switch animation {
        case .idle: mapItemIsIncluded ? "minus" : "plus"
        case .success: "checkmark.circle.fill"
        case .error: "xmark.circle.fill"
        }
    }

    private var removeFromProjectString: LocalizedStringKey {
        "remove_from_project \(selectedProject.name ?? "")"
    }

    private var addToProjectString: LocalizedStringKey {
        "add_to_project \(selectedProject.name ?? "")"
    }

    private var buttonTintColor: Color {
        switch animation {
        case .idle: mapItemIsIncluded ? .red : .accentColor
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
        .animation(.smooth, value: animation)
        .playSound(
            isPlaying: .constant(animation == .success),
            sound: .workoutSavedHaptic
        )
        .resetToIdle($animation, after: 2.5)
    }

    // -------------------------------------------------------------------------
    // MARK: - Actions
    // -------------------------------------------------------------------------

    private func onTapButton() {
        if mapItemIsIncluded {
            removeMapMarker(from: selectedProject)
            playAddSucceedAnimation()
        } else {
            addMapMarker(to: selectedProject)
            playAddSucceedAnimation()

        }
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

    private func removeMapMarker(from project: TripProjectEntity) {
        guard let entity = project.points.first(
            where: { $0.asSameSourcePoint(as: tripPoint) }
        ) else { return }

        viewContext.delete(entity)

        try? viewContext.save()
    }

    // -------------------------------------------------------------------------
    // MARK: - Animations
    // -------------------------------------------------------------------------

    private func playAddSucceedAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animation = .success
        }
    }
}

#Preview {
    AddOrRemoveFromProjectButton(
        tripPoint: .mocks.first!,
        selectedProject: .previewExample
    )
}
