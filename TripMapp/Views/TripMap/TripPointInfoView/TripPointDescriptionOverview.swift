//
//  DefaultMapMarkerInfoView.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 07/03/2024.
//

import SwiftUI
import MapKit

/// Display some textual informations about a TripPoint
struct TripPointDescriptionOverview: View {

    // -------------------------------------------------------------------------
    // MARK: - Parameters
    // -------------------------------------------------------------------------

    /// Trip point displaying its informations
    let tripPoint: TripPoint

    /// The current project, where the current trip point can be included on, or cannot be
    var currentProject: TripProjectEntity?

    @EnvironmentObject private var router: AppRouter

    @Environment(\.managedObjectContext) private var viewContext

    // -------------------------------------------------------------------------
    // MARK: - Private
    // -------------------------------------------------------------------------

    @State private var shouldOpenDetailedResult: Bool = false

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        VStack(alignment: .leading) {
            Label(tripPoint.name, systemImage: tripPoint.systemImage)
                .font(.headline)

            HStack {
                VStack(alignment: .leading) {
                    Text(tripPoint.shortDescription)
                        .lineLimit(3)
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    HStack(spacing: 16.0) {
                        addOrRemoveFromProjectButton()
                            .buttonStyle(.borderedProminent)
                            .font(.caption)

                        Spacer()

                        Button("open_details_title", systemImage: "arrow.up.right.square") {
                            shouldOpenDetailedResult = true
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $shouldOpenDetailedResult) {
            if case .refugesInfo = tripPoint.source,
                let refugeId = tripPoint.sourceId?.toInt {
                router.createRefugeDetailView(refugeId: refugeId) // TODO: not using AppRouter
            }
        }
    }

    @ViewBuilder private func addOrRemoveFromProjectButton() -> some View {
        if let currentProject {
            // If there is a project selected
            // the user can add or remove the point from the project directly
            AddOrRemoveFromProjectButton(
                tripPoint: tripPoint,
                selectedProject: currentProject
            )
        } else {
            // If there is no project selected
            // he can only add it to some project he'll select after
            AddToProjectButton(tripPoint: tripPoint)
        }
    }
}

#Preview {
    VStack {
        TripPointDescriptionOverview(
            tripPoint: .mocks.first!,
            currentProject: nil
        )

        Divider()

        TripPointDescriptionOverview(
            tripPoint: .mocks.first!,
            currentProject: .previewExample
        )
    }
    .configureEnvironmentForPreview()
}
