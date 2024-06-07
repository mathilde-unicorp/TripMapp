//
//  PointsOfInterestTypeEntity+extensions.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 26/06/2024.
//

import CoreData

extension PointsOfInterestTypeEntity {

    var toPointOfInterestType: POIType? {
        POIType(rawValue: Int(self.id))
    }
}

// =============================================================================
// MARK: - Initialization
// =============================================================================

extension PointsOfInterestTypeEntity {
    convenience init(
        context: NSManagedObjectContext,
        pointsOfInterestType: POIType
    ) {
        self.init(context: context)
        self.id = Int64(pointsOfInterestType.id)
    }
}
