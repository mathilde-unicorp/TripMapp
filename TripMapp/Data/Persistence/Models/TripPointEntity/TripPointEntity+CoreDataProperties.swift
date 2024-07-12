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

    @NSManaged public var id: UUID?
    @NSManaged public var latitude: Float
    @NSManaged public var longitude: Float
    @NSManaged public var name: String?
    @NSManaged public var source: String?
    @NSManaged public var type: Int16
    @NSManaged public var sourceId: String?
    @NSManaged public var position: Int16
    @NSManaged public var project: NSSet?

    // -------------------------------------------------------------------------
    // MARK: - Computed Properties
    // -------------------------------------------------------------------------

    /// Convert entity to a TripPointType
    var tripPointType: TripPointType? {
        TripPointType(rawValue: Int(self.type))
    }

    // -------------------------------------------------------------------------
    // MARK: - Update
    // -------------------------------------------------------------------------

    /// First setup of the entity
    @discardableResult
    func setup(name: String, type: TripPointType) -> Self {
        self.id = UUID()
        self.name = name
        self.type = Int16(type.id)
        self.position = 0
        return self
    }

    @discardableResult
    func setup(source: TripPointSource, sourceId: String) -> Self {
        self.source = source.rawValue
        self.sourceId = sourceId
        return self
    }

    @discardableResult
    func setupLocation(latitude: CGFloat, longitude: CGFloat) -> Self {
        self.latitude = Float(latitude)
        self.longitude = Float(latitude)
        return self
    }

    @discardableResult
    func update(position: Int16) -> Self {
        self.position = position
        return self
    }
}

extension TripPointEntity {

    // -------------------------------------------------------------------------
    // MARK: - Fetch Requests
    // -------------------------------------------------------------------------

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TripPointEntity> {
        return NSFetchRequest<TripPointEntity>(entityName: "TripPointEntity")
    }

    @nonobjc public class func sortedFetchRequest() -> NSFetchRequest<TripPointEntity> {
        let request = TripPointEntity.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \TripPointEntity.id, ascending: true)
        ]
        return request
    }

}

extension TripPointEntity {

    // -------------------------------------------------------------------------
    // MARK: - Generated accessors for project
    // -------------------------------------------------------------------------

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
