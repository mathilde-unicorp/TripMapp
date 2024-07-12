//
//  PersistenceController+PointsOfInterest.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/07/2024.
//

import CoreData

extension NSManagedObjectContext {

    @discardableResult
    func createTripPointTypeEntity(
        type: TripPointType
    ) -> TripPointTypeEntity? {
        let entity = TripPointTypeEntity(context: self)
        entity.id = Int16(type.id)

        do {
            try self.save()
            return entity
        } catch {
            print("Got error while saving entity: \(entity)")
            return nil
        }
    }

    func deleteTripPointTypeEntity(
        _ entity: TripPointTypeEntity
    ) {
        do {
            self.delete(entity)
            try self.save()
        } catch {
            print("Got error while deleting entity: \(entity)")
        }
    }
}
