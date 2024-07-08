//
//  PersistenceController+setup.swift
//  TripMapp
//
//  Created by Ressier Mathilde on 08/07/2024.
//

import Foundation

extension PersistenceController {
    func setupDefaultFavoritePOITypes() {
        let poiTypes: [POIType] = [.summit, .foodstuffProvisions, .publicTransport, .refuge]

        for poiType in poiTypes {
            context.createPointsOfInterestTypeEntity(type: poiType)
        }
    }
}
