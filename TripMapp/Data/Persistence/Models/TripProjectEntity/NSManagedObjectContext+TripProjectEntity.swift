//
//  PersistenceController+TripProject.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 05/07/2024.
//

import CoreData

extension NSManagedObjectContext {

    // -------------------------------------------------------------------------
    // MARK: - Write
    // -------------------------------------------------------------------------

    @discardableResult
    func createTripProjectEntity(
        name: String,
        startDate: Date? = nil,
        endDate: Date? = nil
    ) -> TripProjectEntity? {
        let entity = TripProjectEntity(context: self)
        entity.id = UUID()
        entity.name = name
        entity.startDate = startDate
        entity.endDate = endDate

        do {
            try self.save()
            return entity
        } catch {
            print("Got error while saving entity: \(entity)")
        }
        return nil
    }

    @discardableResult
    func update(
        entity: TripProjectEntity,
        with project: TripProject
    ) -> TripProjectEntity? {
        entity.name = project.name
        entity.startDate = project.startDate
        entity.endDate = project.endDate
        entity.notes = project.notes

        do {
            try self.save()
            return entity
        } catch {
            print("Got error while saving entity: \(entity)")
        }
        return nil
    }

}
