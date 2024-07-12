//
//  PersistenceController+preview.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/06/2024.
//

import CoreData

extension PersistenceController {

    static var preview = PersistenceController(inMemory: true)

    func generateInMemoryContent() {
        do {
            try generateTripProjectEntities()
            try generatePointsOfInterestsEntities()
        } catch {
            print("CANNOT CREATE PREVIEW CONTENT ON PERSISTENCE CONTROLLER: \(error)")
        }
    }

    private func generateTripProjectEntities() throws {
        for index in 0 ..< 10 {
            context.createTripProjectEntity(name: "Project \(index)")
        }
    }

    private func generatePointsOfInterestsEntities() throws {
        let tripPointTypes: [TripPointType] = [.foodstuffProvisions, .refuge, .water, .campground]

        for tripPointType in tripPointTypes {
            context.createTripPointTypeEntity(type: tripPointType)
        }
    }
}
