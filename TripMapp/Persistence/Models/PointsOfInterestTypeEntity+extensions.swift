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

    // -------------------------------------------------------------------------
    // MARK: - Fetch Requests
    // -------------------------------------------------------------------------

    static var allPointsOfInterestTypes: NSFetchRequest<PointsOfInterestTypeEntity> {
        let request = PointsOfInterestTypeEntity.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \PointsOfInterestTypeEntity.id, ascending: true)
        ]
        return request
    }
}
