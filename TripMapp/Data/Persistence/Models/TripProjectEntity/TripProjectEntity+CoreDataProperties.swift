//
//  TripProjectEntity+CoreDataProperties.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 12/07/2024.
//
//

import Foundation
import CoreData

extension TripProjectEntity {

    @NSManaged public var endDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var point: NSSet?

    // -------------------------------------------------------------------------
    // MARK: - Fetch Requests
    // -------------------------------------------------------------------------

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TripProjectEntity> {
        return NSFetchRequest<TripProjectEntity>(entityName: "TripProjectEntity")
    }

    @nonobjc public class func sortedFetchRequest() -> NSFetchRequest<TripProjectEntity> {
        let request = TripProjectEntity.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \TripProjectEntity.startDate, ascending: false),
            NSSortDescriptor(keyPath: \TripProjectEntity.name, ascending: true)
        ]
        return request
    }

    // -------------------------------------------------------------------------
    // MARK: - Computed Properties
    // -------------------------------------------------------------------------

    public var points: [TripPointEntity] {
        let set = point as? Set<TripPointEntity> ?? []

        return set.sorted { $0.id < $1.id }
    }
}

// MARK: Generated accessors for point
extension TripProjectEntity {

    @objc(addPointObject:)
    @NSManaged public func addToPoint(_ value: TripPointEntity)

    @objc(removePointObject:)
    @NSManaged public func removeFromPoint(_ value: TripPointEntity)

    @objc(addPoint:)
    @NSManaged public func addToPoint(_ values: NSSet)

    @objc(removePoint:)
    @NSManaged public func removeFromPoint(_ values: NSSet)

}

extension TripProjectEntity: Identifiable {

}
