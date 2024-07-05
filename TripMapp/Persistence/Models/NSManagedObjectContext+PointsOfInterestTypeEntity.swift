//
//  PersistenceController+PointsOfInterest.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/07/2024.
//


import CoreData

extension NSManagedObjectContext {

    @discardableResult
    func createPointsOfInterestTypeEntity(
        type: POIType
    ) -> PointsOfInterestTypeEntity? {
        let entity = PointsOfInterestTypeEntity(context: self)
        entity.id = Int64(type.id)

        do {
            try self.save()
            return entity
        } catch {
            print("Got error while saving entity: \(entity)")
            return nil
        }
    }

    func deletePointsOfInterestTypeEntity(
        _ entity: PointsOfInterestTypeEntity
    ) {
        do {
            self.delete(entity)
            try self.save()
        } catch {
            print("Got error while deleting entity: \(entity)")
        }
    }
}
