//
//  TripPointEntity+CoreDataProperties.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 12/07/2024.
//
//

import Foundation
import CoreData

extension TripPointEntity {

    @NSManaged public var id: String?
    @NSManaged public var source: String?
    @NSManaged public var name: String?
    @NSManaged public var latitude: Float
    @NSManaged public var longitude: Float
    @NSManaged public var type: Int16
    @NSManaged public var project: NSSet?

    // -------------------------------------------------------------------------
    // MARK: - Fetch Requests
    // -------------------------------------------------------------------------

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TripPointEntity> {
        return NSFetchRequest<TripPointEntity>(entityName: "TripPointEntity")
    }

    // -------------------------------------------------------------------------
    // MARK: - Computed Properties
    // -------------------------------------------------------------------------

    /// Convert entity to a TripPointType
    var tripPointType: TripPointType? {
        TripPointType(rawValue: Int(self.type))
    }
}

// MARK: Generated accessors for project
extension TripPointEntity {

    @objc(addProjectObject:)
    @NSManaged public func addToProject(_ value: TripProjectEntity)

    @objc(removeProjectObject:)
    @NSManaged public func removeFromProject(_ value: TripProjectEntity)

    @objc(addProject:)
    @NSManaged public func addToProject(_ values: NSSet)

    @objc(removeProject:)
    @NSManaged public func removeFromProject(_ values: NSSet)

}

extension TripPointEntity: Identifiable {

}
