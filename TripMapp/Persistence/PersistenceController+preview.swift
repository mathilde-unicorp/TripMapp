//
//  PersistenceController+preview.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/06/2024.
//

import CoreData

extension PersistenceController {

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        generateTripProjectEntity(viewContext: viewContext)
        generatePointsOfInterestsEntity(viewContext: viewContext)

        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    private static func generateTripProjectEntity(viewContext: NSManagedObjectContext) {
        for index in 0 ..< 10 {
            _ = TripProjectEntity(context: viewContext, name: "Project \(index)")
        }
    }

    private static func generatePointsOfInterestsEntity(viewContext: NSManagedObjectContext) {
        let poiTypes: [POIType] = [.foodstuffProvisions, .refuge, .water, .campground]

        for poiType in poiTypes {
            _ = PointsOfInterestTypeEntity(context: viewContext, pointsOfInterestType: poiType)
        }
    }
}
