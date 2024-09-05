//
//  TripProjectsList.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 16/05/2024.
//

import SwiftUI
import CoreData

struct TripProjectRow: View {

    // -------------------------------------------------------------------------
    // MARK: - Parameters
    // -------------------------------------------------------------------------

    let project: TripProjectEntity

    // -------------------------------------------------------------------------
    // MARK: - Body
    // -------------------------------------------------------------------------

    var body: some View {
        HStack {
            Image("ProjectImagePlaceholder")
                .resizable()
                .frame(width: 60, height: 60)
                .scaledToFill()
                .clipped()

            VStack(alignment: .leading) {
                Text(project.name ?? "")
                    .font(.body)

                if let startDate = project.startDate {
                    Text(startDate.formatted())
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }

    /// Add informations about the number of points included on the project
    /// If `checkTripPointIncluded` is specified ->
    ///     if this tripPoint is already in the project, it disabled the row and add a message about it
    @ViewBuilder
    func withPointsDetails(checkTripPointIncluded tripPoint: TripPoint? = nil) -> some View {
        let isMapItemAlreadyAdded = isAlreadyAdded(tripPoint: tripPoint, in: project)

        VStack(alignment: .leading) {
            self

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

    private func isAlreadyAdded(tripPoint: TripPoint?, in project: TripProjectEntity) -> Bool {
        guard let tripPoint else { return false }

        return project.contains(marker: tripPoint)
    }

}

#Preview {
    List {
        TripProjectRow(project: .previewExample)

        TripProjectRow(project: .previewExample)
            .withPointsDetails()

        TripProjectRow(project: .previewExample)
            .withPointsDetails(checkTripPointIncluded: .mocks.first!)
    }
}
