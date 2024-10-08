//
//  PersistenceController+preview.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/06/2024.
//

import CoreData
import MapKit

extension PersistenceRepository {

    /// Generate fake content for inMemory persistence controller (currently used for preview)
    func generateInMemoryContent() {
        do {
            try generateTripProjectEntities()
            try generateFavoriteTripPointTypeEntities()
        } catch {
            print("ERROR: CANNOT CREATE PREVIEW CONTENT ON PERSISTENCE CONTROLLER: \(error)")
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Private
    // -------------------------------------------------------------------------

    private func generateTripProjectEntities() throws {
        for index in 0 ..< 10 {
            let project = TripProjectEntity(context: context)
                .setup(name: "Project \(index)")

            if index == 0 {
                try generateProjectPoints(project: project)
            }
        }
        try? context.save()
    }

    private func generateFavoriteTripPointTypeEntities() throws {
        let tripPointTypes: [TripPointType] = [.foodstuffProvisions, .refuge, .water, .campground]

        for tripPointType in tripPointTypes {
            TripPointTypeEntity(context: context)
                .setup(type: tripPointType)
        }
        try? context.save()
    }

    private func generateProjectPoints(project: TripProjectEntity) throws {
        TripPointEntity(context: context)
            .setup(name: "marker 1", type: .refuge)
            .setup(source: .refugesInfo, sourceId: "1")
            .setupLocation(coordinates: .cabaneClartan)
            .addToProject(project)

        try? context.save()
    }
}
