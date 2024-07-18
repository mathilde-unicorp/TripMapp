//
//  TripPointTypeEntity+CoreDataProperties.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 12/07/2024.
//
//

import Foundation
import CoreData

extension TripPointTypeEntity {

    @NSManaged public var id: Int16

    // -------------------------------------------------------------------------
    // MARK: - Computed Properties
    // -------------------------------------------------------------------------

    /// Convert entity to a TripPointType
    var tripPointType: TripPointType? {
        TripPointType(rawValue: Int(self.id))
    }

    // -------------------------------------------------------------------------
    // MARK: - Update
    // -------------------------------------------------------------------------

    @discardableResult
    func setup(type: TripPointType) -> Self {
        self.id = Int16(type.id)
        return self
    }
}

extension TripPointTypeEntity {

    // -------------------------------------------------------------------------
    // MARK: - Fetch Requests
    // -------------------------------------------------------------------------

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TripPointTypeEntity> {
        return NSFetchRequest<TripPointTypeEntity>(entityName: "TripPointTypeEntity")
    }

    @nonobjc public class func sortedFetchRequest() -> NSFetchRequest<TripPointTypeEntity> {
        let request = TripPointTypeEntity.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \TripPointTypeEntity.id, ascending: true)
        ]
        return request
    }

}

extension TripPointTypeEntity: Identifiable {

}
