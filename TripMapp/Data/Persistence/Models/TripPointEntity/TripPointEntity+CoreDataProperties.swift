//
//  TripPointEntity+CoreDataProperties.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 12/07/2024.
//
//

import Foundation
import CoreData
import MapKit

extension TripPointEntity {

    @NSManaged public var id: UUID?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
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
    func setup(name: String, type: TripPointType?) -> Self {
        self.id = UUID()
        self.name = name
        self.position = 0

        if let type {
            self.type = Int16(type.id)
        } else {
            self.type = -1
        }
        return self
    }

    @discardableResult
    func setup(source: TripPoint.Source) -> Self {
        self.source = source.name
        self.sourceId = source.sourceId
        return self
    }

    @discardableResult
    func setupLocation(latitude: Double, longitude: Double) -> Self {
        self.latitude = latitude
        self.longitude = longitude
        return self
    }

    @discardableResult
    func setupLocation(coordinates: CLLocationCoordinate2D) -> Self {
        self.latitude = coordinates.latitude
        self.longitude = coordinates.longitude
        return self
    }

    @discardableResult
    func update(position: Int16) -> Self {
        self.position = position
        return self
    }

    // -------------------------------------------------------------------------
    // MARK: - Methods
    // -------------------------------------------------------------------------

    func asSameSourcePoint(as otherPoint: TripPointEntity) -> Bool {
        if self.source != otherPoint.source {
            return false
        }

        if let sourceId, let otherSourceId = otherPoint.sourceId {
            return otherSourceId != sourceId
        }

        return false
    }

    func asSameSourcePoint(as marker: TripPoint) -> Bool {
        guard self.source == marker.source.name else {
            return false
        }

        // Compare sourceIds if there are presents
        if let sourceId, let otherSourceId = marker.source.sourceId {
            return otherSourceId == sourceId
        }

        // When no source id, compare name and locations to avoid duplicated content
        return self.name == marker.name
        && String(format: "%.6f", self.latitude) == String(format: "%.6f", marker.coordinates.latitude)
        && String(format: "%.6f", self.longitude) == String(format: "%.6f", marker.coordinates.longitude)
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
