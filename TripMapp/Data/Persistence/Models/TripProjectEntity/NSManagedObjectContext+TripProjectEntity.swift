//
//  NSManagedObject+TripProjectEntity.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 16/07/2024.
//

import CoreData

extension NSManagedObjectContext {

    /// Complete delete of a TripProjectEntity including the points related to this project
    func deleteTripProject(_ entity: TripProjectEntity) {
        entity.points.forEach { self.delete($0) }

        self.delete(entity)
    }

}
