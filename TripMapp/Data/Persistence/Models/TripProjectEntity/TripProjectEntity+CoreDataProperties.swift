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

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var startDate: Date?
    @NSManaged public var endDate: Date?
    @NSManaged public var notes: String?
    @NSManaged public var point: NSSet?

    // -------------------------------------------------------------------------
    // MARK: - Computed Properties
    // -------------------------------------------------------------------------

    public var points: [TripPointEntity] {
        let set = point as? Set<TripPointEntity> ?? []

        return set.sorted {
            if $0.position == $1.position {
                return ($0.name ?? "") < ($1.name ?? "")
            } else {
                return $0.position < $1.position
            }
        }
    }

    // -------------------------------------------------------------------------
    // MARK: - Update object
    // -------------------------------------------------------------------------

    /// First setup of the entity with a name and optionnaly a start and end date
    @discardableResult
    func setup(
        name: String,
        startDate: Date? = nil,
        endDate: Date? = nil
    ) -> Self {
        self.id = UUID()
        self.name = name
        self.startDate = startDate
        self.endDate = endDate

        return self
    }

    /// Update the entity with values from `TripProject` object
    @discardableResult
    func update(with project: TripProject) -> Self {
        self.name = project.name
        self.startDate = project.startDate
        self.endDate = project.endDate
        self.notes = project.notes
        return self
    }

    // -------------------------------------------------------------------------
    // MARK: - Methods
    // -------------------------------------------------------------------------

    func contains(marker: TripPoint) -> Bool {
        return self.points.contains { $0.asSameSourcePoint(as: marker) }
    }
}

extension TripProjectEntity {

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

}

extension TripProjectEntity {

    // -------------------------------------------------------------------------
    // MARK: - Generated accessors for point
    // -------------------------------------------------------------------------

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
